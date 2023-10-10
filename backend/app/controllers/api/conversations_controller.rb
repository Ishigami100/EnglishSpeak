class Api::ConversationsController < ApplicationController
    def show
        conversations=ConversationHistory.select(:id, :context, :conversation_times, :gpt_flag).where(userid:params[:id]);
        render json: conversations
    end

    def create
        
    end
end
