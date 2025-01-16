# frozen_string_literal: true

class TopController < BaseController
  def index
    @daily_task_set = current_user.daily_task_sets.find_by(date: Time.zone.today)
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
    @notes = current_user.notes.includes(%i[link link_note event event_note task task_note reading
                                            reading_note]).today.order(created_at: :desc)
    @today_tasks = current_user.scheduled_tasks.today.includes(:task).order(created_at: :asc)
  end
end
