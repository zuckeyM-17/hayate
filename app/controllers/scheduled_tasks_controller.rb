# frozen_string_literal: true

class ScheduledTasksController < BaseController
  def create
    @today_task = current_user.tasks.find(params[:task_id]).schedule_for_today!
  end

  def update
    @scheduled_task = current_user.today_tasks.find(params[:id])
    task = @scheduled_task.task
    @note = Note.new(user: current_user, body: <<~BODY)
      #{ApplicationController.helpers.task_category(task.category)} [#{task.title}](#{task_path(task)}) Done
    BODY

    ApplicationRecord.transaction do
      @scheduled_task.done!
      @note.save!
    end
  end

  private

  def create_params
    params.require(:today_task).permit(:task_id)
  end
end
