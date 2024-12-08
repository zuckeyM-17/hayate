# frozen_string_literal: true

class TopController < BaseController
  def index
    @daily_task_set = current_user.daily_task_sets.find_by(date: Time.zone.today)
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
    @notes = current_user.notes.today.order(created_at: :desc)
  end
end
