module Slack
  class Attachment
    ATTRIBUTES = %i(fallback text title title_link image_url color pretext)

    ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end

    attr_reader :fields, :author

    def initialize(options = {})
      @fields = []

      ATTRIBUTES.each do |attribute|
        self.send("#{attribute}=", options.delete(attribute))
      end
    end

    def add_field(title, value, short = false)
      self.fields << Field.new(title, value, short)
    end


    def author=(author)
      @author = author
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
