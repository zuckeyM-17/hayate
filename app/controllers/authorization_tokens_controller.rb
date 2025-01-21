# frozen_string_literal: true

class AuthorizationTokensController < BaseController
  def index
    @authorization_tokens = current_user.authorization_tokens
  end

  def create
    @authorization_token = current_user.authorization_tokens.create!(create_params)
  end

  def destroy
    @authorization_token = current_user.authorization_tokens.find(params[:id])
    @authorization_token.destroy!
  end

  private

  def create_params
    params.expect(authorization_token: [:name])
  end
end
