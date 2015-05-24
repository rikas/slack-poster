require 'spec_helper'

describe Slack::Poster do
  let(:poster) { described_class.new(SecureRandom.base64) }

  let(:options) do
    {
      username: SecureRandom.hex[0..5],
      channel: "##{SecureRandom.hex[0..5]}",
      icon_url: SecureRandom.hex[0..5],
      icon_emoji: SecureRandom.hex[0..5]
    }
  end

  let(:with_options) { described_class.new(SecureRandom.base64, options) }

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

    describe "#{option_attr}" do
      it "gets the #{option_attr} field in options hash" do
        expect(with_options.send(option_attr)).to eq(with_options.options[option_attr])
      end
    end
  end

  describe '#send_message' do
    it 'accepts a message object' do
    end

    it 'accepts a string' do
    end
  end
end
