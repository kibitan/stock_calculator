module StockCalculator
  class Notifier
    require 'stock_calculator/notifier/slack'
    require 'stock_calculator/notifier/stdout'

    class << self
      def notify(result, output: :stdout)
        new(result, output: output).notify
      end
    end

    attr_reader :result, :output, :output_class

    def initialize(result, output:)
      @result = result
      @output = output
      @output_class = self.class.const_get(output.capitalize)
    end

    # TODO: optionize max_precision
    MAX_PRECISION = 3.freeze
    def notify_text
      # TODO: define to helper class
      number_to_percentage = ->(n) { "#{(n * 100).floor(MAX_PRECISION).to_f}%" }
      # TODO: define as ERB file
      <<~EOS
        Stock Symbol: #{result.stock_symbol}
        Date: #{result.start_date} ~ #{result.end_date}

        Rate of return: #{number_to_percentage.call(result.rate_of_return)}
        Max Drawdown: #{number_to_percentage.call(result.max_drawdown)}
      EOS
    end

    def notify
      @output_class.notify(text: notify_text)
    end
  end
end
