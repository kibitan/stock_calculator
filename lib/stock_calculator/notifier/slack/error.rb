module StockCalculator
  module Notifier
    class Error < StandardError; end
    class Slack::NoWebhookUrl < Error; end
  end
end
