require 'bigdecimal'

module StockCalculator
  module Calculator
    class RateOfReturn
      class NegativeNumber < StandardError; end
      class Zero < StandardError; end
      class InvalidArgument < StandardError; end

      class << self
        def calculate(initial_value:, final_value:)
          new(initial_value: initial_value, final_value: final_value).send(:calculate)
        end
      end

      private

      attr_reader :initial_value, :final_value

      def initialize(initial_value:, final_value:)
        @initial_value = initial_value
        @final_value = final_value
        validate_values
      end

      def calculate
        # NOTE:
        #   Rate of return - Wikipedia
        #   https://en.wikipedia.org/wiki/Rate_of_return#Return
        (final_value - initial_value) / initial_value
      end

      def validate_values
        raise InvalidArgument unless initial_value.is_a? BigDecimal
        raise InvalidArgument unless final_value.is_a? BigDecimal

        raise NegativeNumber if initial_value < 0
        raise NegativeNumber if final_value < 0

        raise Zero if initial_value == 0
        raise Zero if final_value == 0
      end
    end
  end
end
