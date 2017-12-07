module StockCalculator
  class Notifier::Slack::Error < StandardError; end
  class Notifier::Slack::NoWebhookUrl < Notifier::Slack::Error; end
  class Notifier::Slack::APIError < Notifier::Slack::Error; end
  class Notifier::Slack::InvalidUrl < Notifier::Slack::Error; end
end
