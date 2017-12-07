RSpec.describe StockCalculator::Cli do
  describe '#execute' do
    subject { StockCalculator::Cli.new.execute(stock_symbol, start_date) }
    let(:stock_symbol) { 'AAPL' }
    let(:start_date) { '2017-12-5' }

    it 'call Main.run' do
      expect(StockCalculator).to receive(:run)
        .with(stock_symbol: 'AAPL', start_date: '2017-12-5')

      expect { subject }.not_to raise_error
    end

    context 'raise StockCalculator::InvalidDate' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::InvalidDate)
      end

      it do
        expect { subject }.to output("invalid start date\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::OutOfDate' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::OutOfDate)
      end

      it do
        expect { subject }.to output("start date should be up to today\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::Quandl::NoAPIKey' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Quandl::NoAPIKey)
      end

      it do
        expect { subject }.to output("please set Quandl API key to environment variable QUANDL_API_KEY\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::Quandl::NoData' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Quandl::NoData)
      end

      it do
        expect { subject }.to output("No stock data, please check stock symbol/start date is correct\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::Quandl::InvalidAPIKey' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Quandl::InvalidAPIKey)
      end

      it do
        expect { subject }.to output("Quandl API key is invalid, please check Quandl API key is correct\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::Notifier::Slack::NoWebhookUrl' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Notifier::Slack::NoWebhookUrl)
      end

      it do
        expect { subject }.to output("for notifying Slack, please set Incoming Webhook URL to environment variable SLACK_WEBHOOK_URL\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

    context 'raise StockCalculator::Notifier::Slack::InvalidUrl' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Notifier::Slack::InvalidUrl)
      end

      it do
        expect { subject }.to output("Slack Incoming Webhook URL is not valid url, please check Incoming Webhook URL is correct\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end


    context 'raise StockCalculator::Notifier::Slack::APIError' do
      before do
        allow(StockCalculator).to receive(:run)
          .and_raise(StockCalculator::Notifier::Slack::APIError)
      end

      it do
        expect { subject }.to output("failed to notify Slack, please check Incoming Webhook URL is correct\n").to_stderr
        expect { subject }.not_to raise_error
      end
    end

  end
end
