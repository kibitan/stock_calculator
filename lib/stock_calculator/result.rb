module StockCalculator
  class Result
    attr_reader :stock_symbol, :start_date, :end_date

    def initialize(stock_symbol:, start_date:, end_date:)
      @stock_symbol = stock_symbol
      @start_date = start_date
      @end_date = end_date
    end
  end
end
