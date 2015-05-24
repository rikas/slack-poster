module Slack
  class Attachment
    ATTRIBUTES = [:fallback, :text, :title, :title_link, :image_url, :color, :pretext, :author]

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

      hash.merge!(fields: fields.map(&:as_json)) unless fields.empty?
      hash.merge!(author: author.as_json) if author

      hash
    end
  end
end
