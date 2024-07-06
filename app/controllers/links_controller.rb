# frozen_string_literal: true

class LinksController < ApplicationController
  def index
    @links = Link.order(created_at: :desc).page(params[:page])
    @links = @links.unread if params[:all].blank?
    @link = Link.new
  end

  # def show
  #   @link = Link.find(params[:id])
  # end

  def create
    url = link_params[:url]
    title = Link.get_title(url) || url
    Link.create!(title:, url:)

    redirect_to links_path
  end

  def destroy
    link = Link.find(params[:id])
    link.destroy!
    redirect_to links_path
  end

  def read
    link = Link.find(params[:id])
    link.read!
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end
end
