# frozen_string_literal: true

class ReadingsController < BaseController
  def show
    @reading = current_user.readings.find(params[:id])
  end
end
