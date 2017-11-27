require 'stock_calculator/quandl/errors'
require 'net/http'
require 'json'

module StockCalculator
  module Quandl
    class Response
      attr_reader :request_url

      def initialize(request_url:)
        @request_url = request_url
        call_api!
      end

      def call_api!
        # NOTE: https://docs.quandl.com/docs/error-codes
        raise InvalidAPIKey if status_code == '400' && content['quandl_error']['code'] == "QEAx01"
      end

      private

      def net_http_response
        @net_http_response ||= Net::HTTP.get_response(request_url)
      end

      def content
        @content ||= JSON(net_http_response.body)
      end

      def status_code
        @status_code ||= net_http_response.code
      end
    end
  end
end
