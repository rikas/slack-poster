# frozen_string_literal: true

require 'slack/version'
require 'slack/field'
require 'slack/message'
require 'slack/attachment'
require 'json'
require 'faraday'

module Slack
  class Poster
    attr_accessor :options

    # Define getters and setters for the options hash keys. This will make assign of the options
    # more flexible.
    [:username, :channel, :icon_url, :icon_emoji].each do |option_attr|
      define_method(option_attr) { @options[option_attr] }
      define_method("#{option_attr}=") { |value| @options[option_attr] = value }
    end

    # Initializes a Poster instance to post messages with an incoming webhook URL.
    # It also accepts an options hash. If no options are given then the poster uses the default
    # configuration from Slack integration.
    #
    # ==== Examples
    #
    #   # Without options
    #   Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va')
    #
    #   # With options using a custom username and icon avatar
    #   Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va',
    #     username: 'Ricardo',
    #     icon_url: 'http://www.gravatar.com/avatar/92e00fd27c64c94d04140cef88039468.png')
    #
    #   # You can also use an emoji as avatar
    #   Slack::Poster.new('https://hooks.slack.com/services/T044G6VBA//TCIzZQQd7IKhQzCKc6W310va',
    #     username: 'Ricardo',
    #     icon_emoji: 'ghost')
    def initialize(webhook_url, options = {})
      @base_uri = webhook_url

      @options = options

      raise ArgumentError, 'Webhook URL is required' if webhook_url.nil?
    end

    # Sends a message to Slack. The message can be either plain text or a Slack::Message object.
    #
    # ==== Examples
    #
    #   # Plain text message
    #   poster.send_message('hello world')
    #
    #   # Using a message object
    #   poster.send_message(Slack::Message.new(text: 'hello world'))
    #
    # You can have messages with attachments if you build your message with a Slack::Message object
    # and add Slack::Attachment objects.
    def send_message(message)
      body = message.is_a?(String) ? options.merge(text: message) : options.merge(message.as_json)

      conn = Faraday.new(url: @base_uri)

      response = conn.post('', payload: body.to_json)

      response
    end
  end
end
