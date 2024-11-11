# frozen_string_literal: true

class DailyTasksController < BaseController
  def update
    task = current_user.daily_tasks.find(params[:id])
    task.update!(done: update_params[:done])

    redirect_to root_path(last_week: update_params[:last_week])
  end

  private

  def update_params
    params.permit(:done, :last_week)
  end
end
