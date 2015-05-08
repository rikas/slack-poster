require 'httparty'

module Slack
  class Poster
    include HTTParty

    attr_accessor :url, :options, :attachments

    # The format of the response. This comes back as 'ok' from slack.
    format :plain

    # Disable the use of rails query string format.
    #
    # With rails query string format enabled:
    #   => get '/', :query => {:selected_ids => [1,2,3]}
    #
    # Would translate to this:
    #   => /?selected_ids[]=1&selected_ids[]=2&selected_ids[]=3
    disable_rails_query_string_format

    # Initializes a Poster instance to post messages with an incoming webhook URL.
    # It also accepts an options hash. If no options are given then the poster uses the default
    # configuration from Slack integration.
    #
    # ==== Examples
    #
    # Without options
    #   => Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va')
    #
    # With options using a custom username and icon avatar:
    #   => Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va',
    #        username: 'Ricardo',
    #        icon_url: 'http://www.gravatar.com/avatar/92e00fd27c64c94d04140cef88039468.png')
    #
    # You can also use an emoji as avatar:
    #   => Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va',
    #        username: 'Ricardo',
    #        icon_emoji: 'ghost')
    def initialize(webhook_url, options = {})
      self.class.base_uri(webhook_url)

      @attachments = []

      @options = options

      raise ArgumentError, 'Webhook URL is required' if webhook_url.nil?
    end

    # Sends a message to Slack. The message can be either plain text or a Slack::Message object.
    #
    # ==== Examples
    #
    # Plain text message
    #   => poster.send_message('hello world')
    #
    # Using a message object
    #   => poster.send_message(Slack::Message.new(text: 'hello world'))
    #
    # You can have messages with attachments if you build your message with a Slack::Message object
    # and add Slack::Attachment objects.
    def send_message(message)
      body = message.is_a?(String) ? options.merge(text: message) : options.merge(message.as_json)

      attach_extras(body) unless attachments.empty?

      response = self.class.post('', { body: { payload: body.to_json }})

      "#{response.body} (#{response.code})"
    end
  end
end
