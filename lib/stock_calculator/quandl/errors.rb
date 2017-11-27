module StockCalculator
  module Quandl
    class NoAPIKey < StandardError; end
    class InvlaidStockSymbol < StandardError; end
  end
end
