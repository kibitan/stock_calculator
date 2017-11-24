require 'spec_helper'
require_relative '../stock_calculator'

require 'date'
require 'timecop'

RSpec.describe StockCalculator do
  describe ".run" do
    subject { StockCalculator.run(stock_symbol: stock_symbol, start_date: start_date) }
    before { Timecop.freeze(Time.local(2017, 11, 22, 10, 0, 0)) }
    after { Timecop.return }

    after do
      Timecop.return
    end

    context 'with valid `stock_symbol` argument' do
      let(:stock_symbol) { 'AAPL' }

      context 'with valid `start_date` argument: string' do
        let(:start_date) { '2017-11-18' }

        it 'return StockCalculator::Result' do
          is_expected.to be_instance_of StockCalculator::Result
          expect(subject.stock_symbol).to eq 'AAPL'
          expect(subject.start_date).to eq Date.new(2017, 11, 18)
          expect(subject.today).to eq Date.new(2017, 11, 22)
        end
      end

      context 'with valid `start_date` argument: date' do
        let(:start_date) { Date.new(2017, 11, 18) }

        it 'return StockCalculator::Result' do
          is_expected.to be_instance_of StockCalculator::Result
          expect(subject.stock_symbol).to eq 'AAPL'
          expect(subject.start_date).to eq Date.new(2017, 11, 18)
          expect(subject.today).to eq Date.new(2017, 11, 22)
        end
      end

      context 'with invalid `start_date` argument: integer' do
        let(:start_date) { 12345 }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect{subject}.to raise_error StockCalculator::Error::InvalidDate
        end
      end

      context 'with invalid `start_date` argument: invalid string' do
        let(:start_date) { 'aaa' }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect{subject}.to raise_error StockCalculator::Error::InvalidDate
        end
      end

      context 'with invalid `start_date` argument: not existed date' do
        let(:start_date) { '2017-11-31' }

        it 'raise StockCalculator::Error::InvalidDate' do
          expect{subject}.to raise_error StockCalculator::Error::InvalidDate
        end
      end
    end
  end
end
