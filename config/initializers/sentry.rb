# frozen_string_literal: true

Sentry.init do |config|
  config.enabled_environments = %w[production]
  config.dsn = Rails.application.credentials.dig(:sentry_dsn_url)
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]
  config.traces_sample_rate = 1.0
  config.traces_sampler = lambda do |context|
    true
  end
  config.profiles_sample_rate = 1.0
end