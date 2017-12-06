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

    context 'with result: sample1' do
      let(:result) do
        OpenStruct.new(
          stock_symbol: 'AAPL',
          start_date: Date.new(2017, 11, 22),
          end_date: Date.new(2017, 12, 03),
          rate_of_return: BigDecimal('0.2109876543'),
          max_drawdown: BigDecimal('0.345678901')
        )
      end

      it do
        is_expected.to eq <<~EOS
          Stock Symbol: AAPL
          Date: 2017-11-22 ~ 2017-12-03

          Rate of return: 21.098%
          Max Drawdown: 34.567%
        EOS
      end
    end

    context 'with result: sample2' do
      let(:result) do
        OpenStruct.new(
          stock_symbol: 'GOOG',
          start_date: Date.new(2015, 11, 10),
          end_date: Date.new(2017, 11, 22),
          rate_of_return: BigDecimal('-0.567890'),
          max_drawdown: BigDecimal(1) / BigDecimal(3) # 1/3r
        )
      end

      it do
        is_expected.to eq <<~EOS
          Stock Symbol: GOOG
          Date: 2015-11-10 ~ 2017-11-22

          Rate of return: -56.789%
          Max Drawdown: 33.333%
        EOS
      end
    end
  end

  describe '.notify' do
    subject { StockCalculator::Notifier.notify('dummy_result', output: output) }

    before do
      allow_any_instance_of(StockCalculator::Notifier).to receive(:notify_text)
        .and_return('dummy')
    end

    context 'with output: :stdout' do
      let(:output) { :stdout }

      it 'call StockCalculator::Notifier::Stdout.notify and return true' do
        expect(StockCalculator::Notifier::Stdout).to receive(:notify).and_return(true)
        is_expected.to be true
      end
    end

    context 'with output: :slack' do
      let(:output) { :slack }

      it 'call StockCalculator::Notifier::Slack.notify and return true' do
        expect(StockCalculator::Notifier::Slack).to receive(:notify).and_return(true)
        is_expected.to be true
      end
    end
  end
end
