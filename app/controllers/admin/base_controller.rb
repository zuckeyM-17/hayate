# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authenticate if Rails.env.production?

    private

    def authenticate
      authenticate_or_request_with_http_basic do |username, _password|
        username == Rails.application.credentials.dig(:basic_auth, :username) &&
          - Rails.application.credentials.dig(:basic_auth, :password)
      end
    end
  end
end
