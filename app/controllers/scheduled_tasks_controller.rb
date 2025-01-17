# frozen_string_literal: true

class ScheduledTasksController < BaseController
  def create
    @scheduled_task = current_user.tasks.find(params[:task_id]).schedule_for_today!
  end

  def update
    @scheduled_task = current_user.today_tasks.find(params[:id])
    @scheduled_task.reschedule_for_tommorow!
  end

  private

  def create_params
    params.require(:today_task).permit(:task_id)
  end
end
