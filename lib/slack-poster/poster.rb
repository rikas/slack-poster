require 'httparty'

module Slack
  class Poster
    include HTTParty

    attr_accessor :config

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
    # ==== Examples:
    #
    # Without configuration hash
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8')
    #
    # With configuration using username and icon avatar:
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8', username: 'Im a Bot',
    #        icon_url: 'http://www.gravatar.com/avatar/92e00fd27c64c94d04140cef88039468.png')
    #
    # You can also use an emoji as avatar:
    #   => Slack::Poster.new('myteam', 'eNmZHQY6f591ziHyZdzePFz8', username: 'Im a Bot',
    #        icon_emoji: 'ghost')
    #
    def initialize(team, token, config = {})
      self.class.base_uri "https://#{team}.slack.com/services/hooks/incoming-webhook"
      self.class.default_params token: token

      @config = config
    end

    def post(channel, text)
      message_payload = MessagePayload.new(channel, text)
      message = { payload: message_payload }.to_json
      puts message
    end
  end
end