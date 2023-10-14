class Api::UserwordsController < ApplicationController
    skip_before_action :verify_authenticity_token
    def show
        userwords = UserWord.select(:id,:word_number,:count).where(userid: params[:id])

        userword_objects = userwords.map do |userword|
        word = Word.select(:word).find_by(id: userword.word_number)
        p word.word
        # Create a new object with the original userword attributes and the additional word attribute
        {
            userword: userword,
            word: word.word
        }
        end
        render json: userword_objects
    end

    def create
        wordId = UserWord.find_by(word_number: params["word_number"])
        if word
            return # 該当するレコードが既に存在する場合
        end
        UserWord.create(word_number: params["word_number"],userid: params["userid"],count: 0)
    end
end
