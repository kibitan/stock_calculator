class StockCalculator
  class Error < RuntimeError
    class InvalidDate < Error; end
  end

  class << self
    def run(stock_symbol:, start_date:)
      new(stock_symbol: stock_symbol, start_date: start_date).result
    end
  end

  attr_reader :stock_symbol, :start_date

  def initialize(stock_symbol:, start_date:)
    @stock_symbol = stock_symbol
    @start_date = parse_date(start_date)
  end

  def parse_date(input)
    case input
    when String
      Date.parse(input)
    when Date
      input
    else
      raise Error::InvalidDate
    end
  rescue ArgumentError
    raise Error::InvalidDate
  end

  def result
    Result.new(
      stock_symbol: stock_symbol,
      start_date: start_date
    )
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
