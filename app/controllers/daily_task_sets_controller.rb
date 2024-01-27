# frozen_string_literal: true

class DailyTaskSetsController < ApplicationController
  def all
    @daily_task_sets = DailyTaskSet.includes(:daily_tasks).order(date: :desc).page(params[:page])
    @daily_task_items = DailyTaskItem.enabled.order(:created_at)
  end

  def index
    @daily_task_sets = DailyTaskSet.includes(:daily_tasks).this_week.order(date: :desc)
    @daily_task_items = DailyTaskItem.enabled.order(:created_at)
    return unless @daily_task_items.empty?

    redirect_to daily_task_items_path
    nil
  end

  def create
    DailyTaskSet.init!

    redirect_to daily_task_sets_path
  end
end
