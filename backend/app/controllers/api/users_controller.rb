class Api::UsersController < ApplicationController
    def create
        User.create(username:params["username"],password:params["password"],times:0)
    end
end
