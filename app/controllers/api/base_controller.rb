# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    private

    attr_reader :current_user

    def authenticate!
      # Authozization Header から正規表現を用いて token を取得
      token = request.headers['Authorization']&.match(/\ABearer\s(.+)\z/) { |m| m[1] }
      authorization_token = AuthorizationToken.active.find_by(token: token)

      return render json: { error: 'Unauthorized' }, status: :unauthorized if authorization_token.nil?

      @current_user = authorization_token.user
    end
  end
end
