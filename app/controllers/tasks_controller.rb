# frozen_string_literal: true

class TasksController < BaseController
  def index
    @tasks = current_user.tasks
    @task = Task.new
  end

  def create
    task = Task.new(user: current_user)
    task.assign_attributes(task_params)
    task.save!

    redirect_to tasks_path
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to tasks_path
  end

  def done
    task = current_user.tasks.find(params[:id])
    task.done!
    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :category, :due_at)
  end
end
