module StockCalculator
  class Result
    require 'stock_calculator/quandl/wiki_prices'
    require 'stock_calculator/calculator/rate_of_return'
    require 'stock_calculator/calculator/max_drawdown'

    attr_reader :stock_symbol, :start_date, :end_date

    def initialize(stock_symbol:, start_date:, end_date:)
      @stock_symbol = stock_symbol
      @start_date = start_date
      @end_date = end_date
    end

    def price_datas
      @price_datas ||=
        StockCalculator::Quandl::WikiPrices.find(
          stock_symbol: stock_symbol,
          date: start_date..end_date
        ).datas
    end

    def rate_of_return
      StockCalculator::Calculator::RateOfReturn.calculate(
        initial_value: price_datas.first.open,
        final_value:   price_datas.last.adj_close
      )
    end

    def max_drawdown
      values = []
      values << price_datas.first.open
      price_datas.each do |price_data|
        values << price_data.high
        values << price_data.low
      end
      values << price_datas.last.close

      StockCalculator::Calculator::MaxDrawdown.calculate(values)
    end
  end
end
