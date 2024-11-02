# frozen_string_literal: true

class ReadingsController < ApplicationController
  def show
    @reading = current_user.readings.find(params[:id])
  end
end
