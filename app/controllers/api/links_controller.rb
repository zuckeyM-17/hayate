# frozen_string_literal: true

class Api::LinksController < ApplicationController
  protect_from_forgery

  def create
    url = link_params[:url]
    title = Link.get_title(url) || url
    Link.create!(title:, url:)

    head :created
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
