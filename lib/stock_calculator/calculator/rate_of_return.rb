require 'bigdecimal'

module StockCalculator
  module Calculator
    class RateOfReturn
      class NegativeNumber < StandardError; end
      class Zero < StandardError; end
      class InvalidArgument < StandardError; end

      class << self
        def calculate(initial_value:, final_value:)
          new(initial_value: initial_value, final_value: final_value).calculate
        end
      end

      def initialize(initial_value:, final_value:)
        @initial_value = initial_value
        @final_value = final_value
        check_values
      end

      def calculate
        (@final_value - @initial_value) / @initial_value
      end

      private

      def check_values
        raise InvalidArgument unless @initial_value.is_a? BigDecimal
        raise InvalidArgument unless @final_value.is_a? BigDecimal

        raise NegativeNumber if @initial_value < 0
        raise NegativeNumber if @final_value < 0

        raise Zero if @initial_value == 0
        raise Zero if @final_value == 0
      end
    end
  end
end
