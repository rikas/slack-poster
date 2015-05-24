require 'spec_helper'

describe Slack::Message do
  let(:message) { described_class.new('hello') }

  it 'can be initialized with an attachment' do
    attachment = Slack::Attachment.new

    message = described_class.new('hi', attachment)

    expect(message.attachments).to eq([attachment])
  end

  describe '#add_attachment' do
    it 'adds an attachment correctly' do
      attachment = Slack::Attachment.new

      message.add_attachment(attachment)

      expect(message.attachments).to eq([attachment])
    end

    it 'adds multiple attachments correctly' do
      att1 = Slack::Attachment.new
      att2 = Slack::Attachment.new

      message.add_attachment(att1)
      message.add_attachment(att2)

      expect(message.attachments).to eq([att1, att2])
    end
  end

  describe '#as_json' do
    context 'when no attachments were added' do
      it 'returns the correct json' do
        expect(message.as_json).to eq(text: "hello")
      end
    end

    context 'when attachments are added' do
      it 'returns the correct json' do
        att1 = Slack::Attachment.new(text: 'Att1')
        att2 = Slack::Attachment.new(title: 'Att2')

        message.add_attachment(att1)
        message.add_attachment(att2)

        json = { text: 'hello', attachments: [{ text: 'Att1' }, { title: 'Att2' }] }

        expect(message.as_json).to eq(json)
      end
    end
  end
end
