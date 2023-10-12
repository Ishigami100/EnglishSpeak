class Api::ConversationsController < ApplicationController
    def show
        conversations=ConversationHistory.select(:id, :context, :conversation_times, :gpt_flag).where(userid:params[:id]);
        render json: conversations
    end

    def create
        ConversationHistory.create(userid:params[:userid], context:params[:context], conversation_times:0, gpt_flag:false)
        client = OpenAI::Client.new(access_token: ENV["OPENAI_ACCESS_TOKEN"])
        # Define logic to generate response based on user input
        # https://platform.openai.com/docs/api-reference/chat/create
        response = client.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required. # 使用するGPT-3のエンジンを指定
            messages: [{ role: "system", content: "I would like to practice English conversation, so please pretend to be an American man and respond in English to what I say, then follow up with a question." }, { role: "user", content: input }], # Required.
            temperature: 0.7, # 応答のランダム性を指定
            max_tokens: 200,  # 応答の長さを指定
        },
        )
        respond_to do |format|
            format.json { render json: { response: response.dig("choices", 0, "message", "content") } }
        end
    end
end
