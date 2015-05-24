require 'spec_helper'

describe Slack::Attachment do
  describe '.new' do
    let(:options) do
      {
        fallback: 'fallback',
        text: 'text',
        title: 'title',
        title_link: 'title_link',
        image_url: 'image_url',
        color: 'color',
        pretext: 'pretext'
      }
    end

    it 'accepts no attributes' do
      att = described_class.new

      expect(att).to_not be_nil
    end

    it 'initializes all possible option' do
      att = described_class.new(options)

      options.each do |key, value|
        expect(att.send(key)).to eq(value)
      end
    end
  end

  describe '#add_field' do
    context 'when short is set to true' do
    end
  end

  describe '#author=' do
  end

  describe '#as_json' do
  end
end
