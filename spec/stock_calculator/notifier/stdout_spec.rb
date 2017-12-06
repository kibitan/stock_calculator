RSpec.describe StockCalculator::Notifier::Stdout do
  describe '.notify' do
    subject { StockCalculator::Notifier::Stdout.notify(text: text) }

    context 'with valid text' do
      let(:text) { 'hogehogehoge' }

      it 'return true' do
        expect { subject }.to output("hogehogehoge\n").to_stdout
        is_expected.to be true
      end
    end
  end
end
