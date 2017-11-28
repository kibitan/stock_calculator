require 'bigdecimal'

RSpec.describe StockCalculator::Quandl::Data do
  describe ".new" do
    subject do
      StockCalculator::Quandl::Data.new(
        ticker: ticker,
        date: date,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume,
        ex_dividend: ex_dividend,
        split_ratio: split_ratio,
        adj_open: adj_open,
        adj_high: adj_high,
        adj_low: adj_low,
        adj_close: adj_close,
        adj_volume: adj_volume
      )
    end

    context "with raw attributes" do
      let(:ticker) { "AAPL" }
      let(:date) { "2017-11-22" }
      let(:open) { 173.36 }
      let(:high) { 175 }
      let(:low) { 173.05 }
      let(:close) { 174.96 }
      let(:volume) { 24997274 }
      let(:ex_dividend) { 0 }
      let(:split_ratio) { 1 }
      let(:adj_open) { 173.36 }
      let(:adj_high) { 175 }
      let(:adj_low) { 173.05 }
      let(:adj_close) { 174.96 }
      let(:adj_volume) { 24997274 }

      it 'has valid attributes' do
        expect(subject.ticker).to        eq "AAPL"
        expect(subject.date).to          eq Date.new(2017, 11, 22)
        expect(subject.open).to          eq BigDecimal('173.36')
        expect(subject.high).to          eq BigDecimal('175')
        expect(subject.low).to           eq BigDecimal('173.05')
        expect(subject.close).to         eq BigDecimal('174.96')
        expect(subject.volume).to        eq BigDecimal('24997274')
        expect(subject.ex_dividend).to   eq BigDecimal('0')
        expect(subject.split_ratio).to   eq BigDecimal('1')
        expect(subject.adj_open).to      eq Float(173.36)
        expect(subject.adj_high).to      eq Float(175)
        expect(subject.adj_low).to       eq BigDecimal('173.05')
        expect(subject.adj_close).to     eq BigDecimal('174.96')
        expect(subject.adj_volume).to    eq Float(24997274)
      end
    end
  end
end
