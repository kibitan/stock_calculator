require 'stock_calculator/quandl/errors'

module StockCalculator
  module Quandl
    class WikiPrices
      class << self
        def find(stock_symbol:, date:)
          raise NoAPIKey
        end
      end
    end
  end
end
