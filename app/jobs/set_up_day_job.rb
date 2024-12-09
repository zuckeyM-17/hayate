# frozen_string_literal: true

class SetUpDayJob < ApplicationJob
  queue_as :background
  retry_on StandardError, wait: 5.minutes, attempts: 3

  def perform
    User.find_each(batch_size: 10) do |user|
      DailyTaskSet.init!(user: user)
      user.events.today.each do |event|
        Note.create!(user:, body: event.to_note_body)
      end
    end
  end
end
