require 'slack-notifier'

module StockCalculator
  module Notifier
    class Slack
      require 'stock_calculator/notifier/slack/config'

      class << self
        def notify(text:, channel:)
          new.send(:notify, text: text, channel: channel)
        end
      end

      private

      attr_reader :slack_notifier

      def initialize
        @slack_notifier = ::Slack::Notifier.new(Config.webhook_url)
      end

      def notify(text:, channel:)
        slack_notifier.post(text: text, channel: channel)
        true
      rescue ::Slack::Notifier::APIError => e
        raise APIError, e.message
      end
    end
  end
end
