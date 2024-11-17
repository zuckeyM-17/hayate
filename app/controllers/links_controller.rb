# frozen_string_literal: true

class LinksController < BaseController
  def index
    @links = current_user.links.order(created_at: :desc).page(params[:page])
    @links = @links.unread if params[:all].blank?
    @link = current_user.links.new
  end

  def show
    @link = Link.find(params[:id])
  end

  def edit
    @link = current_user.links.find(params[:id])
  end

  def create
    url = link_params[:url]
    title = Link.get_title(url) || url
    Link.create!(title:, url:, user: current_user)

    redirect_to links_path
  end

  def update
    @link = current_user.links.find(params[:id])
    @link.update!(update_params)
    redirect_to @link
  end

  def destroy
    link = current_user.links.find(params[:id])
    link.destroy!
    redirect_to links_path
  end

  def read
    link = current_user.links.find(params[:id])
    link.read!
    redirect_to link
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def update_params
    params.require(:link).permit(:title)
  end
end
