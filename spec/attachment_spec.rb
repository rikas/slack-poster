# frozen_string_literal: true

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
        thumb_url: 'thumb_url',
        color: 'color',
        author_name: 'author_name',
        author_link: 'author_link',
        author_icon: 'author_icon',
        pretext: 'pretext'
      }
    end

    it 'accepts initialization with no attributes' do
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

  describe '#as_json' do
  end
end
