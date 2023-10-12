class Api::UserwordsController < ApplicationController
    def show
        userwords=UserWord.where(userid:params[:id])
        render json: userwords
    end
    
    def create
        wordId = UserWord.find_by(word_number: params["word_number"])
        if word
            return # 該当するレコードが既に存在する場合
        end
        UserWord.create(word_number: params["word_number"],userid:params["userid"],count:0)
    end
end
