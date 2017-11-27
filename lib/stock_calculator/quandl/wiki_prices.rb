require 'stock_calculator/quandl/config'
require 'stock_calculator/quandl/errors'
require 'stock_calculator/quandl/response'

module StockCalculator
  module Quandl
    class WikiPrices
      API_URL = URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES').freeze
      attr_reader :stock_symbol, :date

      class << self
        def find(stock_symbol:, date:)
          new(stock_symbol: stock_symbol, date: date).response
        end
      end

      def initialize(stock_symbol:, date: nil)
        @stock_symbol = stock_symbol
        @date = date
      end

      def response
        Response.new
      end

      def request_url
        @request_url ||= API_URL.dup.tap do |url|
          url.query = URI.encode_www_form(
            {
              api_key: Config.api_key,
              ticker: stock_symbol,
              date: date
            }.compact
          )
        end
      end
    end
  end
end
