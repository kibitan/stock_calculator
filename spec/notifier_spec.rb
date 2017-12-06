RSpec.describe StockCalculator::Notifier do
  require 'ostruct'

  describe '.new' do
    subject { StockCalculator::Notifier.new(result, output: output) }
    let(:result) { 'dummy' }

    context 'with output: :stdout' do
      let(:output) { :stdout }

      it 'has proper attributes' do
        is_expected.to be_instance_of StockCalculator::Notifier
        expect(subject.result).to eq 'dummy'
        expect(subject.output).to eq :stdout
        expect(subject.output_class).to eq StockCalculator::Notifier::Stdout
      end
    end

    context 'with output: :slack' do
      let(:output) { :slack }

      it 'has proper attributes' do
        is_expected.to be_instance_of StockCalculator::Notifier
        expect(subject.result).to eq 'dummy'
        expect(subject.output).to eq :slack
        expect(subject.output_class).to eq StockCalculator::Notifier::Slack
      end
    end
  end

  describe '#notify_text' do
    subject { StockCalculator::Notifier.new(result, output: :stdout).notify_text }

    context 'with result' do
      let(:result) do
        OpenStruct.new(
          stock_symbol: 'AAPL',
          start_date: Date.new(2017, 11, 22),
          end_date: Date.new(2017, 12, 03),
          rate_of_return: BigDecimal('0.2'),
          max_drawdown: BigDecimal('0.3')
        )
      end

      it do
        is_expected.to eq <<-EOS
Stock Symbol: AAPL
Date: 2017-11-22 ~ 2017-12-03

Rate of return: 20.0%
Max Drawdown: 30.0%
        EOS
      end
    end
  end

  pending '.notify' do
    subject { StockCalculator::Notifier.notify(result, output: output) }
    let(:output) { :stdout }

    context 'with output: :stdout' do
      it 'return true' do
        is_expected.to be true
      end

      context 'with output: :slack' do
        it 'return true' do
          is_expected.to be true
        end
      end
    end
  end
end
