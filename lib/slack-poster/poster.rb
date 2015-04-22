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
    def initialize(webhook_url, options = {})
      self.class.base_uri(webhook_url)

      @attachments = []

      @options = options

      raise ArgumentError, 'Webhook URL is required' if webhook_url.nil?
    end

    def send_message(message)
      body = message.is_a?(String) ? options.merge(text: text) : options.merge(message.as_json)

      attach_extras(body) unless attachments.empty?

      response = self.class.post('', { body: { payload: body.to_json }})

      puts body.to_json

      "#{response.body} (#{response.code})"
    end
  end
end
