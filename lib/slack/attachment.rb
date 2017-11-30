# frozen_string_literal: true

module Slack
  class Attachment
    ATTRIBUTES = [
      :fallback, :text, :title, :title_link, :image_url, :thumb_url, :color, :pretext, :author,
      :author_name, :author_link, :author_icon
    ].freeze

    ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end

    attr_reader :fields

    def initialize(options = {})
      @fields = []

      ATTRIBUTES.each do |attribute|
        send("#{attribute}=", options.delete(attribute))
      end
    end

    def add_field(title, value, short = false)
      fields << Field.new(title, value, short)
    end

    def as_json
      hash = {}

      ATTRIBUTES.each do |attribute|
        hash[attribute] = send(attribute) if send(attribute)
      end

      hash[:fields] = fields.map(&:as_json) unless fields.empty?
      hash[:author] = author.as_json if author

      hash
    end
  end
end
