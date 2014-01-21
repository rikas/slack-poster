require 'httparty'

module Slack
  class Poster
    include HTTParty

    attr_accessor :username, :channel

    # The default format of the requests. Used on HTTP header 'Content-Type'.
    format :json

    # Disable the use of rails query string format.
    #
    # With rails query string format enabled:
    #   => get '/', :query => {:selected_ids => [1,2,3]}
    #
    # Would translate to this:
    #   => /?selected_ids[]=1&selected_ids[]=2&selected_ids[]=3
    #
    disable_rails_query_string_format

    # Initializes a Poster instance to post messages. It uses the HTTParty.base_uri and
    # HTTParty.default_params to set parameters of POST request.
    # It also accepts a configuration hash.
    #
    # ==== Examples
    #
    # Without configuration hash
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8')
    #
    # With configuration using username and icon avatar:
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8', username: 'Ricardo',
    #        icon_url: 'http://www.gravatar.com/avatar/92e00fd27c64c94d04140cef88039468.png')
    #
    # You can also use an emoji as avatar:
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8', username: 'Ricardo',
    #        icon_emoji: 'ghost')
    #
    def initialize(team, token, options = {})
      self.class.base_uri("https://#{team}.slack.com/services/hooks/incoming-webhook")
      self.class.default_params(token: token)

      @username = options[:username] || 'webhookbot'
      @channel  = options[:channel] || '#general'

      @icon_emoji = format_emoji(options[:icon_emoji])
      @icon_url = options[:icon_url]

      raise ArgumentError, 'Team name is required' if team.blank?
      raise ArgumentError, 'Token is' if token.blank?
    end

    # This method will post to the configured team Slack.
    def send_message(text)
      payload = { text: text, channel: @channel, username: @username }.merge(avatar_hash)
      puts message
    end

    private

    def avatar_hash
      @icon_emoji ? { icon_emoji: @icon_emoji } : { icon_url: @icon_url }
    end

    def format_emoji(emoji)
      emoji = emoji.to_s.gsub(':', '')
      emoji.empty? ? nil : ":#{emoji}:"
    end
  end
end