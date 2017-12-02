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

  describe '#price_datas' do
    subject do
      StockCalculator::Result.new(
        stock_symbol: stock_symbol,
        start_date:   start_date,
        end_date:     end_date
      ).price_datas
    end

    context 'with valid arguments' do
      let(:stock_symbol) { 'AAPL' }
      let(:start_date) { Date.new(2017, 11, 22) }
      let(:end_date) { Date.new(2017, 11, 25) }

      # TODO: change test for spec from implementation
      before do
        quandl_response = double('StockCalculator::Quandl::Response')
        expect(quandl_response).to receive(:datas)

        expect(StockCalculator::Quandl::WikiPrices).to receive(:find)
                                                       .with(stock_symbol: stock_symbol, date: start_date..end_date)
                                                       .and_return(quandl_response)
      end

      it 'call properly StockCalculator::Quandl::WikiPrices.find' do
        expect { subject }.not_to raise_error
      end
    end
  end
end
