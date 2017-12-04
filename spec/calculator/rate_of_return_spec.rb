RSpec.describe StockCalculator::Calculator::RateOfReturn do
  require 'bigdecimal'

  describe '.calculate' do
    subject do
      StockCalculator::Calculator::RateOfReturn.calculate(
        initial_value: initial_value,
        final_value: final_value
      )
    end

    context do
      let(:initial_value) { BigDecimal(100) }
      let(:final_value) { BigDecimal(200) }

      let!(:previous_initial_value) { initial_value.dup }
      let!(:previous_final_value) { final_value.dup }

      before { subject }

      it 'has no side-effect' do
        expect(initial_value).to eq previous_initial_value
        expect(final_value).to eq previous_final_value
      end
    end

    context 'with argument initial_value: 100, final_value: 200' do
      let(:initial_value) { BigDecimal(100) }
      let(:final_value) { BigDecimal(200) }

      it { is_expected.to eq BigDecimal('1.0') }
    end

    context 'with argument initial_value: 100, final_value: 50' do
      let(:initial_value) { BigDecimal(100) }
      let(:final_value) { BigDecimal(50) }

      it { is_expected.to eq BigDecimal('-0.5') }
    end

    context 'with argument initial_value: 150, final_value: 100' do
      let(:initial_value) { BigDecimal(150) }
      let(:final_value) { BigDecimal(100) }

      it { is_expected.to eql BigDecimal('-0.333333333333333333e0') }
      it { is_expected.to eql(-1/3r) }
    end

    context 'with argument initial_value: 123.45, final_value: 156.78' do
      let(:initial_value) { BigDecimal('123.45') }
      let(:final_value) { BigDecimal('156.78') }

      it { is_expected.to eq BigDecimal('0.269987849331713244228432564e0') }
    end

    context 'with argument initial_value: 190.12, final_value: 134.56' do
      let(:initial_value) { BigDecimal('190.12') }
      let(:final_value) { BigDecimal('134.56') }

      it { is_expected.to eq BigDecimal('-0.292236482221754681253944877e0') }
    end

    context 'when arguments are invalid' do
      context 'with negative number of initial_value' do
        let(:initial_value) { BigDecimal('-1') }
        let(:final_value) { BigDecimal('100.0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::NegativeNumber }
      end

      context 'with negative number of final_value' do
        let(:initial_value) { BigDecimal('100.0') }
        let(:final_value) { BigDecimal('-1') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::NegativeNumber }
      end

      context 'with zero of initial_value' do
        let(:initial_value) { BigDecimal('0') }
        let(:final_value) { BigDecimal('100.0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::Zero }
      end

      context 'with zero of final_value' do
        let(:initial_value) { BigDecimal('100.0') }
        let(:final_value) { BigDecimal('0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::Zero }
      end

      context 'with nil of initial_value' do
        let(:initial_value) { nil }
        let(:final_value) { BigDecimal('100.0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end

      context 'with nil of final_value' do
        let(:initial_value) { BigDecimal('100.0') }
        let(:final_value) { nil }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end

      context 'with integer of initial_value' do
        let(:initial_value) { 100 }
        let(:final_value) { BigDecimal('100.0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end

      context 'with integer of final_value' do
        let(:initial_value) { BigDecimal('100.0') }
        let(:final_value) { 100 }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end

      context 'with float of initial_value' do
        let(:initial_value) { 100.0 }
        let(:final_value) { BigDecimal('100.0') }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end

      context 'with float of final_value' do
        let(:initial_value) { BigDecimal('100.0') }
        let(:final_value) { 100.0 }

        it { expect { subject }.to raise_error StockCalculator::Calculator::RateOfReturn::InvalidArgument }
      end
    end
  end
end
