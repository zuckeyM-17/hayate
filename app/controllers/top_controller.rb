# frozen_string_literal: true

class TopController < ApplicationController
  def index
    @daily_task_sets = DailyTaskSet.includes(:daily_tasks).order(date: :desc)
    @daily_task_sets = if params[:last_week]
                         @daily_task_sets.last_week
                       else
                         @daily_task_sets.this_week
                       end
    @daily_task_items = DailyTaskItem.enabled.order(:created_at)

    @readings = Reading.in_progress
    @notes = Note.today.order(created_at: :desc)
  end
end
