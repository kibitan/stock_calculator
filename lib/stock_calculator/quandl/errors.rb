module StockCalculator
  module Quandl
    class NoAPIKey < StandardError; end
    class NoData < StandardError; end
    class InvalidAPIKey < StandardError; end
  end
end
