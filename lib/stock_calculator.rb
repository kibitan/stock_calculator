require 'stock_calculator/version'
require 'stock_calculator/errors'
require 'stock_calculator/result'
require 'stock_calculator/notifier/slack'

module StockCalculator
  def run(stock_symbol:, start_date:)
    Main.new(stock_symbol: stock_symbol, start_date: start_date).result
  end
  module_function :run

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
