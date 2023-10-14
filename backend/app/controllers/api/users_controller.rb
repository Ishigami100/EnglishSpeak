class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        User.create(username:params["username"],password:params["password"],session_times:0)
    end

    def show
        id=User.select(:id).find_by(username:params["username"])
        render json: id
    end

    def show_session
        user=User.find_by(username:params["username"])
        user.update(session_times: user.session_times+1)
        session_times=User.select(:session_times).find_by(username:params["username"])
        render json:session_times
    end
end
