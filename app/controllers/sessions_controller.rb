# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    render 'new', layout: false
  end

  def create
    user_credential = UserCredential.find_by(display_name: create_params[:display_name])
    if user_credential.authenticate(create_params[:password])
      session[:user_id] = user_credential.user.id
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid display name/password combination'
      render 'new', layout: false
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to signin_path
  end

  private

  def create_params
    params.permit(:display_name, :password)
  end
end
