# frozen_string_literal: true

class DailyTaskSetsController < ApplicationController
  def index
    @daily_task_sets = DailyTaskSet.includes(:daily_tasks).order(date: :desc).page(params[:page])
    @daily_task_items = DailyTaskItem.enabled.order(:created_at)
  end

  def create
    DailyTaskSet.init!(user: current_user)

    redirect_to root_path
  end
end
