# frozen_string_literal: true

class DailyTasksController < ApplicationController
  def update
    task = DailyTask.find(params[:id])
    task.update!(update_params)

    redirect_to root_path
  end

  private

  def update_params
    params.permit(:done)
  end
end
