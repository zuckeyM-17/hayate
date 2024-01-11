# frozen_string_literal: true

class ReadingsController < ApplicationController
  def index
    @readings = Reading.in_progress
  end

  def show
    @reading = Reading.find(params[:id])
  end

  private

  def reading_params
    params.require(:reading).permit(:chapter_id)
  end
end
