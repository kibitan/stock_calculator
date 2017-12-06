module StockCalculator
  require 'date'
  require 'stock_calculator/version'
  require 'stock_calculator/cli'
  require 'stock_calculator/error'
  require 'stock_calculator/result'
  require 'stock_calculator/notifier'

  class << self
    def run(stock_symbol:, start_date:, verbose: false)
      main = Main.new(stock_symbol: stock_symbol, start_date: start_date)
      if verbose
        puts '=' * 5 + 'verbose' + '=' * 5
        main.result.price_datas.each do |price_data|
          puts "ticker: #{price_data.ticker}"
          puts "date: #{price_data.date}"
          puts "open: #{price_data.open.to_f}"
          puts "high: #{price_data.high.to_f}"
          puts "low: #{price_data.low.to_f}"
          puts "close: #{price_data.close.to_f}"
          puts "volume: #{price_data.volume.to_f}"
          puts "ex_dividend: #{price_data.ex_dividend.to_f}"
          puts "split_ratio: #{price_data.split_ratio.to_f}"
          puts "adj_open: #{price_data.adj_open.to_f}"
          puts "adj_high: #{price_data.adj_high.to_f}"
          puts "adj_low: #{price_data.adj_low.to_f}"
          puts "adj_close: #{price_data.adj_close.to_f}"
          puts "adj_volume: #{price_data.adj_volume.to_f}"
          puts
        end
        puts '=' * 5 + 'verbose' + '=' * 5
        puts
      end
      main.notify
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

    def notify
      Notifier.notify(result, output: :stdout)
      Notifier.notify(result, output: :slack) && puts('Notified to Slack!')
      true
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
