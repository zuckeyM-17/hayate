# frozen_string_literal: true

class TopController < BaseController
  # rubocop:disable Metrics/AbcSize
  def index
    @daily_task_set = current_user.daily_task_sets.find_by(date: Time.zone.today)
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
    @notes = current_user.notes.includes(%i[link link_note event event_note task task_note reading
                                            reading_note]).today.order(created_at: :desc)
    @tasks = current_user.tasks.today.todo.order(end_date: :asc)
    today_task_ids = @tasks.map(&:id)
    @weekly_tasks = current_user.tasks.this_week.todo.order(end_date: :asc).reject do |task|
      today_task_ids.include?(task.id)
    end
  end
  # rubocop:enable Metrics/AbcSize
end
