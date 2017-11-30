# frozen_string_literal: true

require 'spec_helper'
require 'securerandom'

describe Slack::Poster do
  let(:hook) { ENV.fetch('SLACK_POSTER_TEST_WEBHOOK') }
  let(:poster) { described_class.new(hook) }

  let(:options) do
    {
      username: SecureRandom.hex[0..5],
      channel: "##{SecureRandom.hex[0..5]}",
      icon_url: SecureRandom.hex[0..5],
      icon_emoji: SecureRandom.hex[0..5]
    }
  end

  let(:with_options) { described_class.new(hook, options) }

  describe '.new' do
    it 'requires the webhook_url' do
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
      expect { described_class.new }.to raise_error(ArgumentError)
    end

    it 'does not need options' do
      expect { described_class.new('my_webhook') }.to_not raise_exception
    end
  end

  [:username, :channel, :icon_url, :icon_emoji].each do |option_attr|
    describe "#{option_attr}=" do
      it "sets the #{option_attr} field in options hash" do
        poster.send("#{option_attr}=", "test_#{option_attr}")

        expect(poster.options[option_attr]).to eq("test_#{option_attr}")
      end
    end

    describe option_attr.to_s do
      it "gets the #{option_attr} field in options hash" do
        expect(with_options.send(option_attr)).to eq(with_options.options[option_attr])
      end
    end
  end

  describe '#send_message' do
    context 'with no attachments' do
      it 'accepts a message object' do
        VCR.use_cassette('default_post') do
          message = Slack::Message.new('Hello world')

          response = poster.send_message(message)

          expect(response).to_not be_nil
          expect(response.env.status).to eq(200)
        end
      end

      it 'accepts a string' do
        VCR.use_cassette('default_post') do
          response = poster.send_message('Hello world')

          expect(response).to_not be_nil
          expect(response.env.status).to eq(200)
        end
      end
    end
  end
end
