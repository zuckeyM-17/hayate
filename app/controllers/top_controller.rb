# frozen_string_literal: true

class TopController < BaseController
  # rubocop:disable Metrics/AbcSize
  def index
    @daily_task_set = current_user.daily_task_sets.find_by(date: Time.zone.today)
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
    @notes = current_user.notes.today.order(created_at: :desc)
    @tasks = current_user.tasks.today.todo
    today_task_ids = @tasks.map(&:id)
    @weekly_tasks = current_user.tasks.this_week.todo.reject { |task| today_task_ids.include?(task.id) }
  end
  # rubocop:enable Metrics/AbcSize
end
