module Slack
  class MessagePayload
    attr_accessor :channel, :username, :text, :icon_url, :icon_emoji

    def initialize(channel, text)
      @channel = channel
      @text = text
    end
  end
end