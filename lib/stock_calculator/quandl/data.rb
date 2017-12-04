module StockCalculator
  module Quandl
    class Data
      require 'bigdecimal'
      require 'bigdecimal/util'

      # NOTE: definition: `curl https://www.quandl.com/api/v3/datatables/WIKI/PRICES/metadata.json`
      attr_reader :ticker,
                  :date,
                  :open,
                  :high,
                  :low,
                  :close,
                  :volume,
                  :ex_dividend,
                  :split_ratio,
                  :adj_open,
                  :adj_high,
                  :adj_low,
                  :adj_close,
                  :adj_volume

      def initialize(**args)
        @ticker      = args[:ticker]
        @date        = Date.parse(args[:date])
        @open        = args[:open].to_d
        @high        = args[:high].to_d
        @low         = args[:low].to_d
        @close       = args[:close].to_d
        @volume      = args[:volume].to_d
        @ex_dividend = args[:ex_dividend].to_d
        @split_ratio = args[:split_ratio].to_f
        @adj_open    = args[:adj_open].to_d
        @adj_high    = args[:adj_high].to_d
        @adj_low     = args[:adj_low].to_d
        @adj_close   = args[:adj_close].to_d
        @adj_volume  = args[:adj_volume].to_f
      end
    end
  end
end
