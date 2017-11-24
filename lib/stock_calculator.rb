require "stock_calculator/version"
require "stock_calculator/error"
require "stock_calculator/result"

module StockCalculator
  def run(stock_symbol:, start_date:)
    Main.new(stock_symbol: stock_symbol, start_date: start_date).result
  end
  module_function :run

  class Main
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
        raise InvalidDate
      end
    rescue ArgumentError
      raise InvalidDate
    end

    def result
      Result.new(
        stock_symbol: stock_symbol,
        start_date: start_date
      )
    end
  end
end
