class Api::UserwordsController < ApplicationController
    def show
        userwords=UserWord.where(userid:params[:id])
        render json: word
    end
    def create
    
    end
end
