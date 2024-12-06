# frozen_string_literal: true

class LogsController < ApplicationController
  def index
    @months = Month.future
  end

  def show
    @month = Month.new(params[:id])
  end
end
