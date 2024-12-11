# frozen_string_literal: true

class FutureLogsController < BaseController
  def show
    @months = Month.future
    @events = current_user
              .events
              .future
              .group_by { |e| Month.date_to_id(e.date) }
              .transform_values { |events| events.sort_by(&:date) }
  end
end