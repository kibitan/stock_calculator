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
  end
end
