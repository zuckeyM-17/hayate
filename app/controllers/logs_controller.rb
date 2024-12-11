# frozen_string_literal: true

class LogsController < BaseController
  def show
    @month = Month.new(params[:id])
    @event = Event.new
    @events = current_user.events.by_month(@month).group_by(&:date)
  end
end
