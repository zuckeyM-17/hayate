# frozen_string_literal: true

class ReviewToolsController < BaseController
  def show
    @readings = current_user.readings.in_progress
  end
end
