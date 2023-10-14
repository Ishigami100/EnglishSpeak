require 'faraday'
class Api::WordsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        word = Word.find_by(word: params["word"])
        if word
            return # 該当するレコードが既に存在する場合
        end
        data = translate(word:params["word"])
        if data.present?
            Word.create(word: params["word"], mean: data)
        else
            # dataが空の場合のエラーハンドリングを追加
            p "エラー: データの翻訳に失敗しました"
        end
    end

    def show
        word = Word.select(:id, :word, :mean).find_by(word:params[:word])
        render json: word
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
end
