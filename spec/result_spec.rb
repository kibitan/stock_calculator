RSpec.describe StockCalculator::Result do
  describe '.new' do
    subject do
      StockCalculator::Result.new(
        stock_symbol: stock_symbol,
        start_date:   start_date,
        end_date:     end_date
      )
    end

    context 'with valid arguments' do
      let(:stock_symbol) { 'AAPL' }
      let(:start_date) { Date.new(2017, 11, 22) }
      let(:end_date) { Date.new(2017, 11, 25) }

      it 'has valid attributes' do
        expect(subject.stock_symbol).to eq 'AAPL'
        expect(subject.start_date).to   eq Date.new(2017, 11, 22)
        expect(subject.end_date).to     eq Date.new(2017, 11, 25)
      end
    end
  end

  describe '.new' do
    subject do
      StockCalculator::Result.new(
        stock_symbol: stock_symbol,
        start_date:   start_date,
        end_date:     end_date
      )
    end

    context 'with valid arguments' do
      let(:stock_symbol) { 'AAPL' }
      let(:start_date) { Date.new(2017, 11, 22) }
      let(:end_date) { Date.new(2017, 11, 25) }

      it 'has valid attributes' do
        expect(subject.stock_symbol).to eq 'AAPL'
        expect(subject.start_date).to   eq Date.new(2017, 11, 22)
        expect(subject.end_date).to     eq Date.new(2017, 11, 25)
      end
    end
  end
end
