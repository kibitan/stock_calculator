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
  end
end
