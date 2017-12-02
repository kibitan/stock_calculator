require 'ostruct'

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

      # TODO: change test of spec from implementation
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

  describe '#rate_of_return' do
    subject do
      StockCalculator::Result.new(
        stock_symbol: 'AAPL',
        start_date:   Date.new(2017, 11, 22),
        end_date:     Date.new(2017, 11, 25)
      ).rate_of_return
    end

    # TODO: refactoring
    before do
      allow_any_instance_of(StockCalculator::Result).to receive(:price_datas)
        .and_return(
          [
            OpenStruct.new(open: initial_value, adj_close: 'dummy'),
            OpenStruct.new(open: 'dummy',       adj_close: 'dummy'),
            OpenStruct.new(open: 'dummy',       adj_close: final_value)
          ]
        )
    end

    let(:initial_value) { 100 }
    let(:final_value)   { 150 }

    it 'call properly StockCalculator::Calculator::RateOfReturn' do
      expect(StockCalculator::Calculator::RateOfReturn).to receive(:calculate)
        .with(initial_value: initial_value, final_value: final_value)

      expect { subject }.not_to raise_error
    end
  end

  describe '#max_drawdown' do
    subject do
      StockCalculator::Result.new(
        stock_symbol: 'AAPL',
        start_date:   Date.new(2017, 11, 22),
        end_date:     Date.new(2017, 11, 25)
      ).max_drawdown
    end

    # TODO: refactoring: tell don't ask
    before do
      allow_any_instance_of(StockCalculator::Result).to receive(:price_datas)
        .and_return(
          [
            OpenStruct.new(high: high_value_1, low: low_value_1),
            OpenStruct.new(high: high_value_2, low: low_value_2),
            OpenStruct.new(high: high_value_3, low: low_value_3)
          ]
        )
    end

    let(:high_value_1)  { 130 }
    let(:low_value_1)   {  90 }
    let(:high_value_2)  { 180 }
    let(:low_value_2)   { 120 }
    let(:high_value_3)  { 200 }
    let(:low_value_3)   { 160 }

    it 'call properly StockCalculator::Calculator::MaxDrawdown' do
      expect(StockCalculator::Calculator::MaxDrawdown).to receive(:calculate)
        .with(
          [
            high_value_1,
            low_value_1,
            high_value_2,
            low_value_2,
            high_value_3,
            low_value_3,
          ]
        )

      expect { subject }.not_to raise_error
    end
  end
end
