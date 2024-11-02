# frozen_string_literal: true

module Api
  class DailyTaskSetsController < ApplicationController
    protect_from_forgery

    def create
      daily_task_set = DailyTaskSet.init!(user: current_user)
      if daily_task_set.nil?
        head :conflict
        return
      end

      head :created
    end
  end
end
