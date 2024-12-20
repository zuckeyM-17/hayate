# frozen_string_literal: true

class DailyTasksController < BaseController
  def update
    @task = current_user.daily_tasks.find(params[:id])
    @task.update!(done: update_params[:done])

    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)
  end

  private

  def update_params
    params.permit(:done)
  end
end
