module Slack
  class Poster
    include HTTParty

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

    def initialize(subdomain, token)
      self.base_uri = "https://#{@subdomain}.slack.com/services/hooks/incoming-webhook"
      self.default_params token: @token
    end

    def post(channel, text)
      message_payload = MessagePayload.new(channel, text)
      puts message_payload.inspect
    end
  end
end