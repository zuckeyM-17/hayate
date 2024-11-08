# frozen_string_literal: true

class FeedsController < ApplicationController
  def index
    @feeds = current_user.feeds.order(created_at: :desc).page(params[:page])
    @feed = current_user.feeds.new
  end

  def show
    @feed = current_user.feeds.find(params[:id])
  end

  def create
    feed = FeedResolver.new(create_params[:url]).resolve
    feed.user = current_user
    feed.save!
    FetchEntriesJob.perform_later(feed.id)
    redirect_to feeds_path
  end

  def update
    @feed = current_user.feeds.find(params[:id])
    @feed.title = edit_params[:title]
    @feed.save!
    redirect_to feed_path(@feed)
  end

  def destroy
    feed = current_user.feeds.find(params[:id])
    feed.destroy!
    redirect_to feeds_path
  end

  private

  def create_params
    params.require(:feed).permit(:url)
  end

  def edit_params
    params.require(:feed).permit(:title)
  end
end
