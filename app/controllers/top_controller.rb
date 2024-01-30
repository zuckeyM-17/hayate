# frozen_string_literal: true

class TopController < ApplicationController
  def index
    @daily_task_sets = DailyTaskSet.includes(:daily_tasks).this_week.order(date: :desc)
    @daily_task_items = DailyTaskItem.enabled.order(:created_at)

    @readings = Reading.in_progress
  end
end
