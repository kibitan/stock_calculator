require 'spec_helper'
require_relative '../stock_calculator'

require 'date'

RSpec.describe StockCalculator do
  describe ".run" do
    subject { StockCalculator.run(stock_symbol: stock_symbol, start_date: start_date) }

    context 'with valid `stock_symbol` argument' do
      let(:stock_symbol) { 'AAPL' }

      context 'with valid `start_date` argument' do
        let(:start_date) { '2017-11-22' }

        it { is_expected.to be_instance_of StockCalculator::Result }
      end
    end
  end
end
