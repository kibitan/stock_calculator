module StockCalculator
  class Notifier::Slack::Config
    require 'stock_calculator/notifier/slack/error'
    require 'singleton'

    include Singleton

    class << self
      def webhook_url
        instance.webhook_url
      end
    end

    def webhook_url
      @webhook_url ||= ENV['SLACK_WEBHOOK_URL'].tap do |webhook_url|
        raise StockCalculator::Notifier::Slack::NoWebhookUrl if webhook_url.nil?
        raise StockCalculator::Notifier::Slack::NoWebhookUrl if webhook_url.empty?
      end
    end
  end
end
