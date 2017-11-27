require 'stock_calculator/quandl/errors'
require 'stock_calculator/quandl/response'

module StockCalculator
  module Quandl
    class WikiPrices

      class << self
        def find(stock_symbol:, date:)
          new(stock_symbol: stock_symbol, date: date).response
        end
      end

      def initialize(stock_symbol:, date:)
        api_key
      end

      def response
        Response.new
      end

      private

      def api_key
        @api_key ||= ENV['QUANDL_API_KEY'].tap do |api_key|
          raise NoAPIKey if api_key.nil?
          raise NoAPIKey if api_key.empty?
        end
      end
    end
  end
end
