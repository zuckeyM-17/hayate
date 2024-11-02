# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.order(due_at: :desc).page(params[:page])
    @tasks = @tasks.todo if params[:all].blank?
    @tasks = @tasks.today if params[:today].present?
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
    params.require(:task).permit(:title, :description, :priority, :category, :due_at)
  end
end
