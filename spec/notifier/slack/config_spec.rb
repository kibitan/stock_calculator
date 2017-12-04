RSpec.describe StockCalculator::Notifier::Slack::Config do
  describe '.webhook_url' do
    subject { StockCalculator::Notifier::Slack::Config.webhook_url }

    before do
      allow(ENV).to receive(:[]).and_call_original
      allow(ENV).to receive(:[]).with('SLACK_WEBHOOK_URL')
                                .and_return(slack_webhook_url)
    end

    context 'when slack_webhook_url is not found' do
      let(:slack_webhook_url) { nil }

      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Notifier::Slack::NoWebhookUrl
      end
    end

    context 'when slack_webhook_url is empty string' do
      let(:slack_webhook_url) { '' }

      it 'raise error' do
        expect { subject }.to raise_error StockCalculator::Notifier::Slack::NoWebhookUrl
      end
    end

    context 'when slack_webhook_url is exists' do
      let(:slack_webhook_url) { 'https://slack.com/fugafuga' }

      it 'return slack_webhook_url' do
        is_expected.to eq 'https://slack.com/fugafuga'
      end
    end
  end
end
