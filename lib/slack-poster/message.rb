module Slack
  class Message
    attr_accessor :text
    attr_reader :attachments

    def initialize(text, attachment = nil)
      @text = text
      @attachments = []
      @attachments << attachment if attachment
    end

    def add_attachment(attachment)
      @attachments << attachment
    end

    def as_json
      hash = { text: text }

      merge_attachments(hash) unless attachments.empty?

      hash
    end

    private

    def merge_attachments(hash)
      json = []

      attachments.each do |attachment|
        json << attachment.as_json
      end

      hash.merge!(attachments: json)
    end
  end
end
