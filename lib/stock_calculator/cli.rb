module StockCalculator
  require 'thor'

  class Cli < ::Thor
    desc 'execute STOCK_SYMBOL START_DATE', 'calculate rate of return, maximum drawdown and notify result'
    def execute(stock_symbol, start_date)
      StockCalculator.run(stock_symbol: stock_symbol, start_date: start_date)
    end
  end
end
