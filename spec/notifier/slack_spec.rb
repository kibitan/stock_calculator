RSpec.describe StockCalculator::Notifier::Slack do
  describe '.notify' do
    # stubbing config
    before do
      allow(StockCalculator::Notifier::Slack::Config).to receive(:webhook_url)
        .and_return(slack_webhook_url)
    end

    # stubbing url
    before do
      stub_request(:post, request_url)
        .with(body: { payload: payload_of_request })
        .to_return(dummy_response_file)
    end
    after { WebMock.reset! }

    context 'with valid webhook url' do
      let(:slack_webhook_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }

      context 'with valid text' do
        let(:text) { "this is the test test!\nHello World!" }

        subject { StockCalculator::Notifier::Slack.notify(text: text) }

        let(:request_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
        let(:payload_of_request) { %Q|{"text":"this is the test test!\\nHello World!"}| }
        let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/success') }

        it 'return true' do
          is_expected.to be true
          expect { subject }.not_to raise_error
        end
      end

      context 'with valid channel' do
        let(:channel) { '#sandbox' }

        context 'with valid text' do
          let(:text) { "this is the test test!\nHello World!" }

          subject do
            StockCalculator::Notifier::Slack.notify(
              text: text,
              channel: channel
            )
          end

          let(:request_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
          let(:payload_of_request) { %Q|{"text":"this is the test test!\\nHello World!","channel":"#sandbox"}| }
          let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/success') }

          it 'return true' do
            is_expected.to be true
            expect { subject }.not_to raise_error
          end
        end

        context 'with invalid text' do
          let(:text) { "" }

          subject do
            StockCalculator::Notifier::Slack.notify(
              text: text,
              channel: channel
            )
          end

          let(:request_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
          let(:payload_of_request) { %Q|{"text":"","channel":"#sandbox"}| }
          let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/invalid_text') }

          it 'raise StockCalculator::Notifier::Slack::APIError' do
            expect { subject }.to raise_error StockCalculator::Notifier::Slack::APIError,
              "The slack API returned an error: missing_text_or_fallback_or_attachments (HTTP Code 500)\n" +
              "Check the \"Handling Errors\" section on https://api.slack.com/incoming-webhooks for more information\n"
          end
        end
      end

      context 'with invalid channel' do
        subject do
          StockCalculator::Notifier::Slack.notify(
            text: text,
            channel: channel
          )
        end

        let(:channel) { '#invalid' }
        let(:text) { "this is the test test!\nHello World!" }

        let(:request_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
        let(:payload_of_request) { %Q|{"text":"this is the test test!\\nHello World!","channel":"#invalid"}| }
        let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/invalid_channel') }

        it 'raise StockCalculator::Notifier::Slack::APIError' do
          expect { subject }.to raise_error StockCalculator::Notifier::Slack::APIError,
            "The slack API returned an error: channel_not_found (HTTP Code 404)\n" +
            "Check the \"Handling Errors\" section on https://api.slack.com/incoming-webhooks for more information\n"
        end
      end
    end

    context 'with invalid webhook url' do
      subject { StockCalculator::Notifier::Slack.notify(text: text) }

      let(:text) { "this is the test test!\nHello World!" }
      let(:payload_of_request) { %Q|{"text":"this is the test test!\\nHello World!"}| }

      context 'invalid token' do
        let(:slack_webhook_url) { 'https://hooks.slack.com/services/T00000000/B00000000/invalid_token' }

        let(:request_url) { 'https://hooks.slack.com/services/T00000000/B00000000/invalid_token' }
        let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/invalid_token') }

        it 'raise StockCalculator::Notifier::Slack::APIError' do
          expect { subject }.to raise_error StockCalculator::Notifier::Slack::APIError,
            "The slack API returned an error: Bad token (HTTP Code 404)\n" +
            "Check the \"Handling Errors\" section on https://api.slack.com/incoming-webhooks for more information\n"
        end
      end

      context 'invalid team' do
        let(:slack_webhook_url) { 'https://hooks.slack.com/services/invalid_team/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }

        let(:request_url) { 'https://hooks.slack.com/services/invalid_team/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
        let(:dummy_response_file) { File.new('spec/notifier/slack/dummy_responses/invalid_team') }

        it 'raise StockCalculator::Notifier::Slack::APIError' do
          expect { subject }.to raise_error StockCalculator::Notifier::Slack::APIError,
            "The slack API returned an error: No team (HTTP Code 404)\n" +
            "Check the \"Handling Errors\" section on https://api.slack.com/incoming-webhooks for more information\n"
        end
      end
    end
  end
end
