# frozen_string_literal: true

class ExampleJob < ApplicationJob
  def perform
    Rails.logger.info 'ExampleJob is running'
  end
end
