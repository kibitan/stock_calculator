module StockCalculator
  module Quandl
    class NoAPIKey < StandardError; end
    class InvlaidStockSymbol < StandardError; end
    class InvalidAPIKey < StandardError; end
  end
end
