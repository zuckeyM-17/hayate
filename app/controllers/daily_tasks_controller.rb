# frozen_string_literal: true

class DailyTasksController < ApplicationController
  def update
    task = DailyTask.find(params[:id])
    task.update!(update_params)

    redirect_to daily_task_sets_path
  end

  private

  def update_params
    params.permit(:done)
  end
end
