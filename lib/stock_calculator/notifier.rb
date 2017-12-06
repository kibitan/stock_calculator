module StockCalculator
  class Notifier
    require 'stock_calculator/notifier/slack'
    require 'stock_calculator/notifier/stdout'

    class << self
      def notify(result, output: :stdout)
        true
      end
    end

    attr_reader :result, :output, :output_class

    def initialize(result, output:)
      @result = result
      @output = output
      @output_class = self.class.const_get(output.capitalize)
    end

    def notify_text
      # TODO: make define as ERB file
<<-EOS
Stock Symbol: #{result.stock_symbol}
Date: #{result.start_date} ~ #{result.end_date}

Rate of return: #{(result.rate_of_return * 100).to_f}%
Max Drawdown: #{(result.max_drawdown * 100).to_f}%
EOS
    end

    def notify
      @output_class.notify(text: notify_text)
      true
    end
  end
end
