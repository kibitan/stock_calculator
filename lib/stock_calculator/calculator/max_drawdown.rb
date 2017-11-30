require 'bigdecimal'
require 'tapp'

module StockCalculator
  module Calculator
    class MaxDrawdown
      class NegativeNumber < StandardError; end
      class Zero < StandardError; end
      class InvalidArgument < StandardError; end
      class NoValues < StandardError; end

      class << self
        def calculate(values)
          new(values).send(:calculate)
        end
      end

      private

      attr_reader :values

      def initialize(values)
        @values = values.dup
        validate_values
      end

      def calculate
        (largest_drop.max - largest_drop.min) / largest_drop.max
      end

      def largest_drop
        @largest_drop ||=
          peak_to_peak_values.map { |peak_to_peak| Range.new(*peak_to_peak.minmax) }
                             .max_by { |range| range.max - range.min }
      end

      def peak_to_peak_values
        peak_to_peak_values = []
        tmp_values = values.dup

        until tmp_values.empty? do
          peak_to_peak_values << tmp_values.slice!(tmp_values.index(tmp_values.max)..-1)
        end

        peak_to_peak_values.reverse
      end

      def validate_values
        raise InvalidArgument unless values.is_a? Array
        raise NoValues if values.size < 2

        values.each do |value|
          raise InvalidArgument unless value.is_a? BigDecimal
          raise NegativeNumber  if value < 0
          raise Zero            if value == 0
        end
      end
    end
  end
end
