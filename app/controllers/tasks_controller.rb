# frozen_string_literal: true

class TasksController < BaseController
  def index
    @tasks = current_user.tasks.todo.order(end_date: :asc)
    @task = Task.new
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @set_date = !!params[:set_date]
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def create
    @task = Task.new(user: current_user)
    @task.assign_attributes(task_params.except(:schedule_for_today))
    ApplicationRecord.transaction do
      @task.save!
      @task.schedule_for_today! if task_params[:schedule_for_today]
    end
    @tasks = current_user.tasks.todo.order(end_date: :asc)
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

  private

  def task_params
    params.expect(task: %i[title description category start_date end_date schedule_for_today])
  end

  def update_params
    params.expect(task: %i[title description category start_date end_date])
  end
end
