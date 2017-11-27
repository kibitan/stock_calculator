RSpec.describe StockCalculator::Quandl::WikiPrices do
  describe ".find" do
    subject do
      StockCalculator::Quandl::WikiPrices.find(
        stock_symbol: stock_symbol,
        date: date
      )
    end

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with("QUANDL_API_KEY")
                                .and_return(quandl_api_key)
    end

    context 'with valid `stock_symbol` argument' do
      let(:stock_symbol) { 'AAPL' }

      context 'with valid `date` argument' do
        let(:date) { Date.today }

        context "when api_key is not found" do
          let(:quandl_api_key) { nil }

          it 'raise error' do
            expect{subject}.to raise_error StockCalculator::Quandl::NoAPIKey
          end
        end

        context 'when api_key is empty string' do
          let(:quandl_api_key) { '' }

          it 'raise error' do
            expect{subject}.to raise_error StockCalculator::Quandl::NoAPIKey
          end
        end

        context 'with api_key' do
          let(:quandl_api_key) { 'abcde' }

          it 'return response' do
            is_expected.to be_instance_of StockCalculator::Quandl::Response
          end
        end
      end
    end

    pending 'with invalid `stock_symbol` argument' do
      let(:stock_symbol) { 'hoge' }
      let(:date) { Date.today }

      it 'raise error' do
        expect{subject}.to raise_error StockCalculator::Quandl::InvlaidStockSymbol
      end
    end
  end
end