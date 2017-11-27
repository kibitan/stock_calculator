RSpec.describe StockCalculator::Quandl::WikiPrices do
  describe ".find" do
    subject do
      StockCalculator::Quandl::WikiPrices.find(
        stock_symbol: stock_symbol,
        date: date
      )
    end

    before do
      allow(ENV).to receive(:[]).with("QUANDL_API_KEY")
                                .and_return(quandl_api_key)
    end

    context 'when api_key is not found' do
      let(:stock_symbol) { 'AAPL' }
      let(:date) { Date.today }
      let(:quandl_api_key) { nil }

      it 'raise error' do
        expect{subject}.to raise_error StockCalculator::Quandl::NoAPIKey
      end
    end

    context 'with invalid `stock_symbol` argument' do
      let(:stock_symbol) { 'hoge' }
      let(:date) { Date.today }

      it 'raise error' do
        expect{subject}.to raise_error StockCalculator::Quandl::InvlaidStockSymbol
      end
    end
  end
end
