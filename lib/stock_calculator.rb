module StockCalculator
  require 'date'
  require 'stock_calculator/version'
  require 'stock_calculator/cli'
  require 'stock_calculator/error'
  require 'stock_calculator/result'
  require 'stock_calculator/notifier/slack'

  class << self
    def run(stock_symbol:, start_date:)
      Main.new(stock_symbol: stock_symbol, start_date: start_date).result
    end
  end

  class Main
    attr_reader :stock_symbol, :start_date, :end_date

    def initialize(stock_symbol:, start_date:)
      @stock_symbol = stock_symbol
      @start_date   = parse_date(start_date)
      @end_date     = Date.today
    end

    def parse_date(date)
      case date
      when String
        Date.parse(date)
      when Date
        date
      else
        raise InvalidDate
      end
    rescue ArgumentError
      raise InvalidDate
    end

    def result
      Result.new(
        stock_symbol: stock_symbol,
        start_date: start_date,
        end_date: end_date
      )
    end
  end
end
