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
  end
end
