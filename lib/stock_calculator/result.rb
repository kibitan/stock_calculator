module StockCalculator
  class Result
    attr_reader :stock_symbol, :start_date, :today

    def initialize(stock_symbol:, start_date:)
      @stock_symbol = stock_symbol
      @start_date = start_date
      @today = Date.today
    end
  end
end
