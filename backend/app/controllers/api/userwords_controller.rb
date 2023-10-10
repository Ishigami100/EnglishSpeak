class Api::UserwordsController < ApplicationController
    def show
        userwords=UserWord.where(userid:params[:id])
        render json: userwords
    end
    
    def create
    
    end
end
