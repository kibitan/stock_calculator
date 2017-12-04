module StockCalculator
  module Quandl
    class Error < StandardError; end
    class NoAPIKey < Error; end
    class NoData < Error; end
    class InvalidAPIKey < Error; end
  end
end
