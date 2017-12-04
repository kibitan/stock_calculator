RSpec.describe StockCalculator::Quandl::Response do
  require 'net/http'
  let(:net_http_response) { Net::HTTP.get_response(request_url) }

  before { stub_request(:get, request_url).to_return(dummy_response_file) }
  after { WebMock.reset! }

  describe '.new' do
    # TODO: refactoring: change Resnponse argument from net_http_response to request_url
    subject { StockCalculator::Quandl::Response.new(net_http_response) }

    context 'with valid Net::HTTP response' do
      let(:request_url) { URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date=2017-11-22&ticker=AAPL') }
      let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/ticker-AAPL_date-2017-11-22') }

      it 'has proper attributes' do
        expect { subject }.not_to raise_error
        expect(subject.net_http_response).to eq net_http_response
        expect(subject.content).to eq JSON <<-JSON, symbolize_names: true
          {"datatable":{"data":[["AAPL","2017-11-22",173.36,175.0,173.05,174.96,24997274.0,0.0,1.0,173.36,175.0,173.05,174.96,24997274.0]],"columns":[{"name":"ticker","type":"String"},{"name":"date","type":"Date"},{"name":"open","type":"BigDecimal(34,12)"},{"name":"high","type":"BigDecimal(34,12)"},{"name":"low","type":"BigDecimal(34,12)"},{"name":"close","type":"BigDecimal(34,12)"},{"name":"volume","type":"BigDecimal(37,15)"},{"name":"ex-dividend","type":"BigDecimal(42,20)"},{"name":"split_ratio","type":"double"},{"name":"adj_open","type":"BigDecimal(50,28)"},{"name":"adj_high","type":"BigDecimal(50,28)"},{"name":"adj_low","type":"BigDecimal(50,28)"},{"name":"adj_close","type":"BigDecimal(50,28)"},{"name":"adj_volume","type":"double"}]},"meta":{"next_cursor_id":null}}
        JSON
        expect(subject.status_code).to eq '200'
      end
    end

    describe '#datas' do
      subject { StockCalculator::Quandl::Response.new(net_http_response).datas }

      context 'with valid Net::HTTP response and sigle data' do
        let(:request_url) { URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&date=2017-11-22&ticker=AAPL') }
        let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/ticker-AAPL_date-2017-11-22') }

        it 'returns proper StockCalculator::Quandl::Data collections' do
          expect(subject).to be_instance_of(Array)
          expect(subject[0]).to be_instance_of(StockCalculator::Quandl::Data)
          expect(subject[0].ticker).to eq 'AAPL'
          expect(subject[0].date).to eq Date.new(2017, 11,22)
          expect(subject[0].open).to eq 173.36
          expect(subject[0].high).to eq 175.0
          expect(subject[0].low).to eq 173.05
          expect(subject[0].close).to eq 174.96
          expect(subject[0].volume).to eq 24997274.0
          expect(subject[0].ex_dividend).to eq  0.0
          expect(subject[0].split_ratio).to eq 1.0
          expect(subject[0].adj_open).to eq 173.36
          expect(subject[0].adj_high).to eq 175.0
          expect(subject[0].adj_low).to eq 173.05
          expect(subject[0].adj_close).to eq 174.96
          expect(subject[0].adj_volume).to eq 24997274.0
        end
      end

      context 'with valid Net::HTTP response and multiple data' do
        let(:request_url) { URI('https://www.quandl.com/api/v3/datatables/WIKI/PRICES?api_key=valid_api_key&ticker=AAPL&date.gt=2017-11-23&date.lt=2017-11-30') }
        let(:dummy_response_file) { File.new('spec/quandl/dummy_responses/ticker-AAPL_date-2017-11-23_to_2017-11-30') }

        it 'returns proper StockCalculator::Quandl::Data collections' do
          expect(subject).to be_instance_of(Array)
          expect(subject.size).to eq 4

          expect(subject[0]).to be_instance_of(StockCalculator::Quandl::Data)
          expect(subject[0].date).to eq Date.new(2017, 11,24)

          expect(subject[1]).to be_instance_of(StockCalculator::Quandl::Data)
          expect(subject[1].date).to eq Date.new(2017, 11,27)

          expect(subject[2]).to be_instance_of(StockCalculator::Quandl::Data)
          expect(subject[2].date).to eq Date.new(2017, 11,28)

          expect(subject[3]).to be_instance_of(StockCalculator::Quandl::Data)
          expect(subject[3].date).to eq Date.new(2017, 11,29)
        end
      end
    end
  end

  describe '#check_errors' do
    subject do
      StockCalculator::Quandl::Response.new(
      Net::HTTP.get_response(request_url))
    end

    pending 'APIError' do
      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Quandl::APIError
      end
    end
  end
end
