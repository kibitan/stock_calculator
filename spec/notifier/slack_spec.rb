RSpec.describe StockCalculator::Notifier::Slack do
  describe '.notify' do
    before do
      allow(StockCalculator::Notifier::Slack::Config).to receive(:webhook_url)
        .and_return(slack_webhook_url)
    end
    let(:slack_webhook_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }

    subject do
      StockCalculator::Notifier::Slack.notify(
        text: text,
        channel: channel
      )
    end

    context 'with valid channel' do
      let(:channel) { '#sandbox' }

      context 'with valid text' do
        let(:text) { "this is the test test!\nHello World!" }
        let(:request_url) {  "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX" }
        let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/success') }

        before do
          stub_request(:post, request_url)
            .with(
              body: {
                payload: %Q|{"text":"this is the test test!\\nHello World!","channel":"#sandbox"}|
                }
              )
            .to_return(dummy_response_file)
        end
        after { WebMock.reset! }

        it 'return true' do
          is_expected.to be true
          expect { subject }.not_to raise_error
        end
      end
    end

    context 'with invalid channel' do
      let(:channel) { '#invalid' }
      let(:text) { "this is the test test!\nHello World!" }

      let(:request_url) {  "https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX" }
      let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/invalid_channel') }

      before do
        stub_request(:post, request_url)
          .with(
            body: {
              payload: %Q|{"text":"this is the test test!\\nHello World!","channel":"#invalid"}|
              }
            )
          .to_return(dummy_response_file)
      end
      after { WebMock.reset! }

      it 'raise StockCalculator::Notifier::Slack::APIError' do
        expect { subject }.to raise_error StockCalculator::Notifier::Slack::APIError,
          "The slack API returned an error: channel_not_found (HTTP Code 404)\n" +
          "Check the \"Handling Errors\" section on https://api.slack.com/incoming-webhooks for more information\n"
      end
    end
  end
end
