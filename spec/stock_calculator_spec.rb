RSpec.describe StockCalculator do
  require 'timecop'

  it 'has a version number' do
    expect(StockCalculator::VERSION).not_to be nil
  end

  describe '.run' do
    subject { StockCalculator.run(stock_symbol: stock_symbol, start_date: start_date) }
    before { Timecop.freeze(Time.local(2017, 11, 22, 10, 0, 0)) }
    after { Timecop.return }

    before { allow_any_instance_of(StockCalculator::Main).to receive(:notify).and_return(true) }

    context 'with valid `stock_symbol` argument' do
      let(:stock_symbol) { 'AAPL' }

      context 'with valid `start_date` argument: string' do
        let(:start_date) { '2017-11-18' }

        it 'return true' do
          is_expected.to be true
        end
      end

      context 'with valid `start_date` argument: date' do
        let(:start_date) { Date.new(2017, 11, 18) }

        it 'return StockCalculator::Result' do
          is_expected.to be true
        end
      end

      context 'with invalid `start_date` argument: tomorrow' do
        let(:start_date) { Date.today + 1 }

        it 'raise StockCalculator::Error::OutOfDate' do
          expect { subject }.to raise_error StockCalculator::OutOfDate
        end
      end

      context 'with invalid `start_date` argument: tomorrow(string)' do
        let(:start_date) { '2017-11-23' }

        it 'raise StockCalculator::Error::OutOfDate' do
          expect { subject }.to raise_error StockCalculator::OutOfDate
        end
      end

      context 'with invalid `start_date` argument: nil' do
        let(:start_date) { nil }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect { subject }.to raise_error StockCalculator::InvalidDate
        end
      end

      context 'with invalid `start_date` argument: integer' do
        let(:start_date) { 12_345 }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect { subject }.to raise_error StockCalculator::InvalidDate
        end
      end

      context 'with invalid `start_date` argument: invalid string' do
        let(:start_date) { 'aaa' }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect { subject }.to raise_error StockCalculator::InvalidDate
        end
      end

      context 'with invalid `start_date` argument: not existed date' do
        let(:start_date) { '2017-11-31' }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect { subject }.to raise_error StockCalculator::InvalidDate
        end
      end
    end
  end

  describe StockCalculator::Main do
    describe '#result' do
      subject { StockCalculator::Main.new(stock_symbol: stock_symbol, start_date: start_date).result }
      before { Timecop.freeze(Time.local(2017, 11, 22, 10, 0, 0)) }
      after { Timecop.return }

      context 'with valid `stock_symbol` argument' do
        let(:stock_symbol) { 'AAPL' }

        context 'with valid `start_date` argument' do
          let(:start_date) { Date.new(2017, 11, 18) }

          it 'return StockCalculator::Result' do
            is_expected.to be_instance_of StockCalculator::Result
            expect(subject.stock_symbol).to eq 'AAPL'
            expect(subject.start_date).to eq Date.new(2017, 11, 18)
            expect(subject.end_date).to eq Date.new(2017, 11, 22)
          end
        end
      end
    end

    describe '#notify' do
      subject { StockCalculator::Main.new(stock_symbol: 'AAPL', start_date: '2017-11-21').notify }
      before do
        allow_any_instance_of(StockCalculator::Notifier).to receive(:notify)
          .with(result, output: :stdout)
          .and_return(true)
        allow_any_instance_of(StockCalculator::Notifier).to receive(:notify)
          .with(result, output: :slack)
          .and_return(true)
      end

      let(:result) { Struct.new(:stock_symbol, :start_date, :end_date) }

      it 'return true' do
        is_expected.to be true
      end
    end
  end
end
