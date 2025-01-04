# frozen_string_literal: true

module Api
  class LinksController < Api::BaseController
    protect_from_forgery

    def create
      authenticate!
      url = link_params[:url]
      title = Link.get_title(url) || url
      link = Link.create!(title:, url:, user: current_user)

      render json: { link: { id: link.id } }
    end

    private

    def link_params
      params.require(:link).permit(:url)
    end
  end
end
