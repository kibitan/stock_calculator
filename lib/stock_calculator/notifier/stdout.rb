module StockCalculator
  class Notifier::Stdout
    class << self
      def notify(text:)
        puts text
        true
      end
    end
  end
end
