module StockCalculator
  require 'date'
  require 'stock_calculator/version'
  require 'stock_calculator/cli'
  require 'stock_calculator/error'
  require 'stock_calculator/result'
  require 'stock_calculator/notifier/slack'
  require 'stock_calculator/notifier/stdout'

  class << self
    def run(stock_symbol:, start_date:)
      Main.new(stock_symbol: stock_symbol, start_date: start_date).notify
    end
  end

  class Main
    attr_reader :stock_symbol, :start_date, :end_date

    def initialize(stock_symbol:, start_date:, end_date: Date.today)
      @stock_symbol = stock_symbol
      @start_date   = parse_date(start_date)
      @end_date     = parse_date(end_date)
    end

    def parse_date(date)
      case date
      when String
        Date.parse(date)
      when Date
        date
      else
        raise InvalidDate
      end.tap do |_date|
        raise OutOfDate if _date > Date.today
      end
    rescue ArgumentError
      raise InvalidDate
    end

    def result
      @result ||= Result.new(
        stock_symbol: stock_symbol,
        start_date: start_date,
        end_date: end_date
      )
    end
  end
end
