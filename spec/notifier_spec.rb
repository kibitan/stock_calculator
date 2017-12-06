RSpec.describe StockCalculator::Notifier do
  require 'ostruct'

  describe '.new' do
    subject { StockCalculator::Notifier.new(result, output: output) }
    let(:result) { 'dummy' }

    context 'with output: :stdout' do
      let(:output) { :stdout }

      it 'has proper attributes' do
        is_expected.to be_instance_of StockCalculator::Notifier
        expect(subject.result).to eq 'dummy'
        expect(subject.output).to eq :stdout
        expect(subject.output_class).to eq StockCalculator::Notifier::Stdout
      end
    end

    context 'with output: :slack' do
      let(:output) { :slack }

      it 'has proper attributes' do
        is_expected.to be_instance_of StockCalculator::Notifier
        expect(subject.result).to eq 'dummy'
        expect(subject.output).to eq :slack
        expect(subject.output_class).to eq StockCalculator::Notifier::Slack
      end
    end
  end

  pending '#notify_text' do
    subject { StockCalculator::Notifier.new(result, output: output).notify_text }
    before { expect(ERB).to receive(:new).with.and_return(text) }
    let(:result) { 'dummy' }
    let(:result) { text }

    context 'with output: :slack' do
      it 'has proper attributes' do
        is_expected.to be_instance_of StockCalculator::Notifier
        expect(subject.result).to eq result
        expect(subject.output).to eq StockCalculator::Notifier::Slack
      end
    end
  end


  pending'.notify' do
    subject { StockCalculator::Notifier.notify(result, output: output) }

    context 'with output: :stdout' do
      it 'return true' do
        is_expected.to be true
      end

      context 'with output: :slack' do
        it 'return true' do
          is_expected.to be true
        end
      end
    end
  end
end
