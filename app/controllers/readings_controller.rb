# frozen_string_literal: true

class ReadingsController < ApplicationController
  def show
    @reading = Reading.find(params[:id])
  end
end
