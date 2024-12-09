# frozen_string_literal: true

class LogsController < BaseController
  def index
    @months = Month.future
    @events = current_user
              .events
              .future
              .group_by { |e| Month.date_to_id(e.date) }
              .transform_values { |events| events.sort_by(&:date) }
  end

  def show
    @month = Month.new(params[:id])
    @event = Event.new
    @events = current_user.events.by_month(@month).group_by(&:date)
  end

  def show_day
    day = Date.parse(params[:day])
    render partial: 'logs/day_show', locals: { events: current_user.events.where(date: day), day: day }
  end

  def add_event
    day = Date.parse(params[:day])
    render partial: 'logs/day_add', locals: { events: current_user.events.where(date: day), day: }
  end

  def create_event
    event = Event.new(user: current_user)
    event.assign_attributes(create_params)
    ApplicationRecord.transaction do
      event.save!
      Note.create!(user: current_user, body: event.to_note_body) if event.today?
    end

    date = event.date
    render partial: 'logs/day_show', locals: { events: current_user.events.by_date(date), day: date }
  end

  private

  def create_params
    params.require(:event).permit(:title, :description, :category, :date)
  end
end
