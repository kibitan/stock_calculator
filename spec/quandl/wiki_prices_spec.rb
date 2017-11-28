RSpec.describe StockCalculator::Quandl::WikiPrices do
  describe '#request_url' do
    before do
      allow(StockCalculator::Quandl::Config).to receive(:api_key)
                                                .and_return(quandl_api_key)
    end

    context 'with api_key' do
      let(:quandl_api_key) { 'hoge' }

      context 'with stock_symbol' do
        let(:stock_symbol) { 'AAPL' }
        subject do
          StockCalculator::Quandl::WikiPrices.new(
            stock_symbol: stock_symbol
          ).request_url
        end

        it 'return valid URL' do
          is_expected.to eq \
            URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=hoge&ticker=AAPL')
        end

        context 'with date' do
          let(:date) { Date.new(2017, 11, 23) }
          subject do
            StockCalculator::Quandl::WikiPrices.new(
              stock_symbol: stock_symbol,
              date: date
            ).request_url
          end

          it 'return valid URL' do
            is_expected.to eq \
              URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=hoge&ticker=AAPL&date=2017-11-23')
          end
        end
      end
    end
  end

  describe '.find' do
    subject do
      StockCalculator::Quandl::WikiPrices.find(
        stock_symbol: stock_symbol,
        date: date
      )
    end

    before do
      allow(StockCalculator::Quandl::Config).to receive(:api_key)
                                                .and_return(quandl_api_key)
    end

    before { stub_request(:get, stub_url).to_return(dummy_response_file) }

    after { WebMock.reset! }

    context 'with valid `stock_symbol` argument' do
      let(:stock_symbol) { 'AAPL' }

      context 'with valid `date` argument' do
        let(:date) { Date.new(2017, 11, 22) }

        context 'when api_key is invalid' do
          let(:quandl_api_key) { 'invalid_api_key' }
          let(:stub_url) { 'https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=invalid_api_key&date=2017-11-22&ticker=AAPL' }
          let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/invalid_api_key') }

          it 'raise error' do
            expect { subject }.to raise_error StockCalculator::Quandl::InvalidAPIKey
          end
        end

        context 'with api_key' do
          let(:quandl_api_key) { 'valid_api_key' }
          let(:stub_url) { 'https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date=2017-11-22&ticker=AAPL' }
          let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/ticker-AAPL_date-2017-11-22') }

          it 'return response' do
            is_expected.to be_instance_of StockCalculator::Quandl::Response
          end
        end
      end
    end

    context 'with invalid `stock_symbol` argument and other valid arguments' do
      let(:stock_symbol) { 'invalid_stock_symbol' }
      let(:date) { Date.new(2017, 11, 23) }
      let(:quandl_api_key) { 'valid_api_key' }

      let(:stub_url) { 'https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date=2017-11-23&ticker=invalid_stock_symbol' }
      let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/no_data') }

      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Quandl::NoData
      end
    end
  end
end
