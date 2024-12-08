# frozen_string_literal: true

class LogsController < BaseController
  def index
    @months = Month.future
  end

  def show
    @month = Month.new(params[:id])
    @event = Event.new
    @events = current_user.events.by_month(@month).group_by(&:date)
  end

  def add_event
    day = Date.parse(params[:day])
    render partial: 'logs/day_add', locals: { events: current_user.events.where(date: day), day: }
  end

  def create_event
    event = Event.new(user: current_user)
    event.assign_attributes(create_params)
    event.save!

    render partial: 'logs/day_show', locals: { events: current_user.events.where(date: event.date), day: event.date }
  end

  private

  def create_params
    params.require(:event).permit(:title, :description, :category, :date)
  end
end
