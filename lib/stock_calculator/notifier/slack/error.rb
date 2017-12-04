module StockCalculator
  module Notifier
    class Slack::Error < StandardError; end
    class Slack::NoWebhookUrl < Slack::Error; end
    class Slack::APIError < Slack::Error; end
  end
end
