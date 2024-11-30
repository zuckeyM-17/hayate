# frozen_string_literal: true

class BaseController < ApplicationController
  before_action :require_login

  private

  def require_login
    redirect_to signin_path unless current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
