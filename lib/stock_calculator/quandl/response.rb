require 'stock_calculator/quandl/errors'
require 'stock_calculator/quandl/data'
require 'json'

module StockCalculator
  module Quandl
    class Response
      attr_reader :net_http_response, :content, :status_code

      def initialize(net_http_response)
        @net_http_response = net_http_response
        @content           = JSON(net_http_response.body, symbolize_names: true)
        @status_code       = net_http_response.code

        # NOTE: https://docs.quandl.com/docs/error-codes
        raise InvalidAPIKey if status_code == '400' && content[:quandl_error][:code] == "QEAx01"

        raise NoData if status_code == '200' && content[:datatable][:data].empty?
      end
    end
  end
end
