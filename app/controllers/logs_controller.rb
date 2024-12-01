# frozen_string_literal: true

class LogsController < ApplicationController
  def index
    @months = Month.future
  end
end
