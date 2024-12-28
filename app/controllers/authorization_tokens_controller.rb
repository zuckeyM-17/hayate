# frozen_string_literal: true

class AuthorizationTokensController < BaseController
  def index
    @authorization_tokens = current_user.authorization_tokens
  end

  def create
    @authorization_token = current_user.authorization_tokens.create!(create_params.merge(token: SecureRandom.hex(16),
                                                                                         expires_at: 1.month.from_now))
    redirect_to authorization_tokens_path # TODO: implement with turbo_stream
  end

  def destroy
    authorization_token = current_user.authorization_tokens.find(params[:id])
    authorization_token.destroy!
    redirect_to authorization_tokens_path # TODO: implement with turbo_stream
  end

  private

  def create_params
    params.require(:authorization_token).permit(:name)
  end
end
