class Api::WordsController < ApplicationController
    def create
        
    end

    def show
        word=Word.select(:id, :word, :mean).find_by(word:params[:word])
        render json: word
    end

end
