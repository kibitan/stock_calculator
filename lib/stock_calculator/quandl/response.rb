require 'stock_calculator/quandl/error'
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
        check_errors
      end

      def datas
        @datas ||= content[:datatable][:data].map do |data|
          Data.new(
            ticker:      data[0],
            date:        data[1],
            open:        data[2],
            high:        data[3],
            low:         data[4],
            close:       data[5],
            volume:      data[6],
            ex_dividend: data[7],
            split_ratio: data[8],
            adj_open:    data[9],
            adj_high:    data[10],
            adj_low:     data[11],
            adj_close:   data[12],
            adj_volume:  data[13]
          )
        end
      end

      def check_errors
        # NOTE: https://docs.quandl.com/docs/error-codes
        raise InvalidAPIKey if status_code == '400' && content[:quandl_error][:code] == 'QEAx01'

        raise NoData if status_code == '200' && content[:datatable][:data].empty?
      end
    end
  end
end
