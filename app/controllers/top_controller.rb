# frozen_string_literal: true

class TopController < ApplicationController
  def index
    daily_task_sets
    @daily_task_items = current_user.daily_task_items.enabled.order(:created_at)

    @readings = current_user.readings.in_progress
    @notes = current_user.notes.today.order(created_at: :desc)
    ExampleJob.perform_later
  end

  private

  def daily_task_sets
    @daily_task_sets = current_user.daily_task_sets.includes(:daily_tasks).order(date: :desc)
    @daily_task_sets = if params[:last_week]
                         @daily_task_sets.last_week
                       else
                         @daily_task_sets.this_week
                       end
  end
end
