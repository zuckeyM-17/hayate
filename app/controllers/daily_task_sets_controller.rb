# frozen_string_literal: true

class DailyTaskSetsController < BaseController
  def index
    @daily_task_sets = current_user.daily_task_sets.includes(:daily_tasks).this_week.order(date: :desc)
    @past_daily_task_sets = DailyTaskSet.includes(:daily_tasks).order(date: :desc).page(params[:page])
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
  end

  def create
    DailyTaskSet.init!(user: current_user)

    daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
    daily_task_set = DailyTaskSet.find_by(date: Time.zone.today)
    render 'daily_task_sets/_date', locals: { daily_task_set:, daily_task_items: }
  end
end
