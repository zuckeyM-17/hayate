# frozen_string_literal: true

class WeeklyObjectivesController < BaseController
  def create
    @weekly_objective = current_user.weekly_objectives.build(weekly_objective_params)
    @weekly_objective.start_date = Time.zone.today.beginning_of_week
    @weekly_objective.end_date = Time.zone.today.end_of_week
    @weekly_objective.save!
  end

  private

  def weekly_objective_params
    params.expect(weekly_objective: [:objective])
  end
end
