class Api::WordsController < ApplicationController
    def create
        
    end

    def show
        word=Word.find_by(word:params[:word])
        render json: word
    end

end
