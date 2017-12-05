module StockCalculator
  module Notifier
    class Stdout
      class << self
        def notify(text: text)
          puts text
          true
        end
      end
    end
  end
end
