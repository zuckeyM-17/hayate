# frozen_string_literal: true

class WeeklyReviewsController < BaseController
  def show
    @readings = current_user.readings.in_progress
    @weekly_objective = current_user.weekly_objectives.current_week.first
  end

  def create
    @weekly_objective = current_user.weekly_objectives.current_week.first
    @weekly_review = @weekly_objective.build_weekly_review(weekly_review_params)
    if @weekly_review.save
      redirect_to weekly_review_path, notice: "Weekly review saved"
    else
      render :show
    end
  end

  private

  def weekly_review_params
    params.expect(weekly_review: [:review])
  end
end
