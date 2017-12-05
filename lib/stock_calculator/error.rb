module StockCalculator
  class Error < StandardError; end
  class InvalidDate < Error; end
  class OutOfDate < Error; end
end
