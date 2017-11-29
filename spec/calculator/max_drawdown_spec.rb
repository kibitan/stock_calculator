RSpec.describe StockCalculator::Calculator::MaxDrawdown do
  describe '.calculate' do
    subject { StockCalculator::Calculator::MaxDrawdown.calculate(values) }

    context 'with valid values samples' do
      context 'sample 1' do
        # NOTE:
        # Max Drawdown Definition
        # https://ycharts.com/glossary/terms/max_drawdown
        let(:values) do
          [
            BigDecimal(100_000),
            BigDecimal(150_000),
            BigDecimal(90_000),
            BigDecimal(120_000),
            BigDecimal(80_000),
            BigDecimal(200_000)
          ]
        end

        it { is_expected.to eq BigDecimal('0.149999466666666666666667e6') }
      end

      pending 'sample 2' do
        it { is_expected.to eq 'pending' }
      end
    end

    context 'with invalid values' do
      context 'not array' do
        let(:values) { Hash.new }
        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::InvalidArgument }
      end

      context 'contain nil' do
        let(:values) do
          [
            BigDecimal(100_000),
            nil,
            BigDecimal(90_000)
          ]
        end

        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::InvalidArgument }
      end

      context 'contain Integer' do
        let(:values) do
          [
            BigDecimal(100_000),
            100,
            BigDecimal(90_000)
          ]
        end

        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::InvalidArgument }
      end

      context 'contain Float' do
        let(:values) do
          [
            BigDecimal(100_000),
            100.0,
            BigDecimal(90_000)
          ]
        end

        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::InvalidArgument }
      end

      context 'contain 0' do
        let(:values) do
          [
            BigDecimal(100_000),
            BigDecimal(0),
            BigDecimal(90_000)
          ]
        end

        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::Zero }
      end

      context 'contain negative number' do
        let(:values) do
          [
            BigDecimal(100_000),
            BigDecimal(-100_000),
            BigDecimal(90_000)
          ]
        end

        it { expect { subject }.to raise_error StockCalculator::Calculator::MaxDrawdown::NegativeNumber }
      end
    end
  end
end
