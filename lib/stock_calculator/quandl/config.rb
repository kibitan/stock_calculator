require 'stock_calculator/quandl/errors'
require 'singleton'

module StockCalculator
  module Quandl
    class Config
      include Singleton

      class << self
        def api_key
          instance.api_key
        end
      end

      def api_key
        @api_key ||= ENV['QUANDL_API_KEY'].tap do |api_key|
          raise NoAPIKey if api_key.nil?
          raise NoAPIKey if api_key.empty?
        end
      end
    end
  end
end
