# frozen_string_literal: true

class TasksController < BaseController
  def index
    @tasks = current_user.tasks.todo.order(end_date: :asc)
    @task = Task.new
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
    task = Task.new(user: current_user)
    task.assign_attributes(task_params)
    task.save!

    redirect_to request.referer
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update!(task_params)
    render 'tasks/_task', locals: { task: @task }
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to tasks_path
  end

  def done
    @task = current_user.tasks.find(params[:id])
    @note = Note.new(user: current_user, body: <<~BODY)
      #{ApplicationController.helpers.task_category(@task.category)} [#{@task.title}](#{task_path(@task)}) Done
    BODY
    ApplicationRecord.transaction do
      @task.done!
      @note.save!
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :category, :start_date, :end_date)
  end

  def update_params
    params.require(:task).permit(:title, :description, :category, :start_date, :end_date)
  end
end
