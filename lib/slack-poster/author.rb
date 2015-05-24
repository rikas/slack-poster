module Slack
  class Author
    ATTRIBUTES = [:name, :link, :icon]

    ATTRIBUTES.each do |attribute|
      attr_accessor attribute
    end

    def initialize(options = {})
      ATTRIBUTES.each do |attribute|
        self.send("#{attribute}=", options.delete(attribute))
      end
    end

    def as_json
      hash = {}

      ATTRIBUTES.each do |attribute|
        hash[attribute] = send(attribute) if send(attribute)
      end

      hash
    end
  end
end
