# frozen_string_literal: true

class FeedsController < BaseController
  def index
    @feeds = current_user.feeds.order(created_at: :desc).page(params[:page])
    @feed = current_user.feeds.new
  end

  def show
    @feed = current_user.feeds.find(params[:id])
    @entries = @feed.entries.order(published_at: :desc).page(params[:page])
  end

  def create
    url, title = FeedResolver.new(create_params[:url]).resolve
    feed = current_user.feeds.find_or_initialize_by(url: url) do |f|
      f.title = title
    end
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
    params.expect(feed: [:url])
  end

  def edit_params
    params.expect(feed: [:title])
  end
end
