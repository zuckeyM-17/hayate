# frozen_string_literal: true

class EntriesController < BaseController
  def index
    @entries = current_user.entries.unread.includes(:feed).order(published_at: :desc).page(params[:page])
  end

  def mark_as_read
    current_user.entries.unread.where(id: mark_as_read_params[:entry_ids]).update_all(read_at: Time.zone.now) # rubocop:disable Rails/SkipsModelValidations
    redirect_to entries_path
  end

  def read
    entry = current_user.entries.unread.find(params[:id])
    entry.read!
    redirect_to entries_path
  end

  def fav
    entry = current_user.entries.unread.find(params[:id])
    entry.read!
    url = entry.url
    title = Link.get_title(url) || url
    Link.create!(title:, url:, user: current_user)
    redirect_to entries_path
  end

  private

  def mark_as_read_params
    params.permit(entry_ids: [])
  end
end
