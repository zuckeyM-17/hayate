# frozen_string_literal: true

class EventsController < BaseController
  def index
    @events = current_user.events.where(date:)
  end

  def show
    @event = current_user.events.find(params[:id])
  end

  def new
    @events = current_user.events.where(date:)
    @event = Event.new
  end

  def create
    @event = Event.new(user: current_user)
    @event.assign_attributes(create_params)
    @event.save_with_note!

    redirect_to events_path(date:)
  end

  private

  def date
    @date ||= Date.parse(params[:date])
  end

  def create_params
    params.require(:event).permit(:title, :description, :category, :date)
  end
end
