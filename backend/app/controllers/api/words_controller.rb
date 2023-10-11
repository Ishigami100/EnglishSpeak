require 'faraday'
class Api::WordsController < ApplicationController
    def create
        if word = Word.find_by(word:word_params)
            return
        else
            data = translate(word_params)
            if data == ''
                return
            else
                Word.create(word:word_params, mean:data)
            end
        end
    end

    def show
        word = Word.select(:id, :word, :mean).find_by(word:params[:word])
        render json: word
    end

    def word_params
        params.permit(:word)
    end
    def translate(word)
        conn = Faraday.new(url: 'https://script.google.com/macros/s/AKfycbydfqOuOeylPG1z_6YGGp97fFHUYuLRNhYiV-3-G7p5L31InF4v3IDx7AY-vBq1yLVp9Q/exec')
        response = conn.get do |req|
          req.params['text'] = word
          req.params['source'] = 'en'
          req.params['target'] = 'jp'
        end
        
    
        if response.success?
          # 成功時の処理
          data = JSON.parse(response.body)
          mean = data['text']
        else
          # 失敗時の処理
          data=''
        end
    end 
end
