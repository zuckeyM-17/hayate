# frozen_string_literal: true

class WeeklyReviewsController < BaseController
  def show
    @readings = current_user.readings.in_progress
    @weekly_objective = current_user.weekly_objectives.current_week.first
    @weekly_review = @weekly_objective.build_weekly_review
  end
end
