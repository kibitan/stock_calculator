require 'stock_calculator/quandl/config'
require 'stock_calculator/quandl/response'
require 'net/http'

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
        Response.new(Net::HTTP.get_response(request_url))
      end

      def request_url
        @request_url ||= API_URL.dup.tap do |url|
          date_query =
            case date
            when Date
              { date: date }
            when Range
              { 'date.gt': date.first, 'date.lt': date.last }
            end

          url.query = URI.encode_www_form(
            {
              api_key: Config.api_key,
              ticker: stock_symbol
            }.merge(date_query).compact
          )
        end
      end
    end
  end
end
