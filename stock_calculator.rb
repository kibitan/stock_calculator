class StockCalculator
  class << self
    def run(stock_symbol: stock_symbol, start_date: start_date)
      Result.new(
        stock_symbol: stock_symbol,
        start_date: Date.parse(start_date)
      )
    end
  end

  class Result
    attr_reader :stock_symbol, :start_date, :today

    def initialize(stock_symbol:, start_date:)
      @stock_symbol = stock_symbol
      @start_date = start_date
      @today = Date.today
    end
  end
end
