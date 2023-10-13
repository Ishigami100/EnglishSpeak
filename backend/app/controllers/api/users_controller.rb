class Api::UsersController < ApplicationController
    skip_before_action :verify_authenticity_token
    def create
        User.create(username:params["username"],password:params["password"],times:0)
    end
end
