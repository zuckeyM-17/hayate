# frozen_string_literal: true

class DailyTasksController < BaseController
  def update
    task = current_user.daily_tasks.find(params[:id])
    task.update!(done: update_params[:done])

    redirect_to daily_task_sets_path
  end

  private

  def update_params
    params.permit(:done)
  end
end
