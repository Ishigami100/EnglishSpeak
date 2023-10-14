
class Api::ConversationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def show
        conversations=ConversationHistory.select(:id, :context, :conversation_times, :gpt_flag).where(userid:params[:id]);
        render json: conversations
    end

    def create
        ConversationHistory.create(userid: params[:userid], context:params[:context], conversation_times:params[:conversation_times], session_times:params[:session_times],gpt_flag:false)

        word_create(params[:context])
        client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
        # Define logic to generate response based on user input
        # https://platform.openai.com/docs/api-reference/chat/create
        response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
            messages: [{ role: "system", content: "I would like to practice English conversation, so please pretend to be an American man and respond in English to what I say, then follow up with a question." }, { role: "user", content: params[:context]}], # Required.
            temperature: 0.7, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        ConversationHistory.create(userid: params[:userid], context:response.dig("choices", 0, "message", "content"), conversation_times:params[:conversation_times], session_times:params[:session_times], gpt_flag:true)
        word_create(response.dig("choices", 0, "message", "content"))
        respond_to do |format|
            format.json { render json: { response: response.dig("choices", 0, "message", "content") ,conversation_times:params[:conversation_times]} }
        end
    end

    def translate(word)
        original_url='https://script.google.com/macros/s/AKfycby4Eoh1XfplqHCTMhLuym2Zbv6hFACqN543-pHnEzAtPlt4olThqEF3-2yfWpdVQ6Ko1Q/exec'
        # クエリパラメータを含めたURLを生成
        url_with_query = "#{original_url}?text=#{word}&source=en&target=ja"

        conn = Faraday.new(url:url_with_query)
        p response = conn.get

        if response.status == 302
            # リダイレクト先URLを取得
            redirect_url = response.headers['Location']
            # リダイレクト先URLに新しいリクエストを送信
            conn = Faraday.new
            response = conn.get(redirect_url)
            if response.success?
                # リダイレクト先URLからデータを取得
                p mean = JSON.parse(response.body)
                data = mean['text']
            else
                # 失敗時の処理
                data = ''
            end
        else
            data=''
        end
    end

    def word_create(context)
        #文字列を置換
        str=context.gsub('.', ' ')
        str=str.gsub(',',' ')
        str=str.gsub('!',' ')
        str=str.gsub('?',' ')
        strs=str.split(' ')

        #文字列をuser_wordに格納
        strs.each do |string|
            id=Word.select(:id).find_by(word:string)
            if id
                userword=UserWord.find_by(word_number:id.id)
                if userword
                    userword.update(count: userword.count+1)
                else
                    UserWord.create(word_number:id.id,userid: params["userid"],count: 1)
                end
            else
                translate_data = translate(string)
                translate_data=translate_data.gsub('?',' ')
                Word.create(word: string, mean: translate_data)
                id=Word.select(:id).find_by(word:string)
                UserWord.create(word_number:id.id,userid: params["userid"],count: 1)
            end
        end
    end
end
