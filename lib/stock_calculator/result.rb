module StockCalculator
  class Result
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
        final_value:   price_datas.last.close
      )
    end

    def max_drawdown
      StockCalculator::Calculator::MaxDrawdown.calculate(
        price_datas.map { |data| [data.high, data.low] }.flatten
      )
    end
  end
end
