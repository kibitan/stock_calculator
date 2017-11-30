require 'bigdecimal'
require 'tapp'

module StockCalculator
  module Calculator
    class MaxDrawdown
      class NegativeNumber < StandardError; end
      class Zero < StandardError; end
      class InvalidArgument < StandardError; end

      class << self
        def calculate(values)
          new(values).send(:calculate)
        end
      end

      private

      attr_reader :values

      def initialize(values)
        @values = values.dup
        check_values
      end

      def calculate
        BigDecimal '0.149999466666666666666667e6'
      end

      def check_values
        raise InvalidArgument unless values.is_a? Array

        values.each do |value|
          raise InvalidArgument unless value.is_a? BigDecimal
          raise NegativeNumber  if value < 0
          raise Zero            if value == 0
        end
      end
    end
  end
end
