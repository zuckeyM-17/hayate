# frozen_string_literal: true

module Admin
  class UsersController < Admin::BaseController
    def index
      @users = User.includes(:user_credential).all
      render 'admin/users/index', layout: 'admin'
    end

    def update
      user = User.find(params[:id])
      user.user_credential.update!(password: update_params[:password])
      redirect_to admin_users_path
    end

    private

    def update_params
      params.permit(:password)
    end
  end
end
