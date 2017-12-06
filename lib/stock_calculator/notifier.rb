module StockCalculator
  class Notifier
    require 'stock_calculator/notifier/slack'
    require 'stock_calculator/notifier/stdout'

    class << self
      def notify(result, output: :stdout)
        true
      end
    end
  end
end
