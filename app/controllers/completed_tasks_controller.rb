# frozen_string_literal: true

class CompletedTasksController < BaseController
  def create
    @task = current_user.tasks.find(params[:task_id])
    @scheduled_task = @task.scheduled_task
    @note = Note.completion_of_task(user: current_user, task: @task)

    ApplicationRecord.transaction do
      @task.complete!
      @note.save!
    end
  end

  private

  def create_params
    params.require(:completed_task).permit(:scheduled_task_id)
  end
end
