# frozen_string_literal: true

module Slack
  class Field
    attr_accessor :title, :value, :short

    def initialize(title, value, short = false)
      @title = title
      @value = value
      @short = short
    end

    def as_json
      {
        title: title,
        value: value,
        short: short
      }
    end
  end
end
