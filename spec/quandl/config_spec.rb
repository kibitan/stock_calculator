RSpec.describe StockCalculator::Quandl::Config do
  describe '.api_key' do
    subject { StockCalculator::Quandl::Config.api_key }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('QUANDL_API_KEY')
                                .and_return(quandl_api_key)
    end

    context 'when api_key is not found' do
      let(:quandl_api_key) { nil }

      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Quandl::NoAPIKey
      end
    end

    context 'when api_key is empty string' do
      let(:quandl_api_key) { '' }

      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Quandl::NoAPIKey
      end
    end

    context 'when api_key is exists' do
      let(:quandl_api_key) { 'hogehogehoge' }

      it 'return api_key' do
        is_expected.to eq 'hogehogehoge'
      end
    end
  end
end
