module SocialNetwork
  # Represents some kind of actor in a social network
  class Actor
    attr_accessor :id, :type
    attr_reader :label

    # @param id [Object] A unique id within one social network. i.e. a String
    # @param type [Object] Some identifier for this type of actor, i.e. a String
    # @param label [String] A human readble name for this {Actor}
    def initialize(id, type, label)
      if id.nil? || id.empty?
        fail ActorIdInvalidError, 'Actor id must not be empty nor nil'
      end

      @id = id.freeze
      @type = type
      @label = label=(label)
    end

    # Tells whether this instance of a {Actor} is equal to another. Equality is
    # defined by equality of {Actor#id their ids} only!
    # @param other [Actor] The other actor to compare this instance against
    # @return [Boolean] True if both {Actor#id actor ids} are the same.
    def ==(other)
      id == other.id
    end

    # Provide a human readable name for a {Actor} in a social network
    # @return [String] Human readable name
    def inspect
      "#{self.class}[#{id}] \"#{label}\""
    end

    def label=(label)
      @label = sanitize(label)
    end

    alias_method :to_s, :inspect

    private

    def sanitize label
      label = SocialNetwork::Helper::ActorLabelSanitizer.sanitize(label)
      label
    end
  end

  # This Exceptio gets raised if you've tried to initialize a {Actor} with a nil
  # or empty {Actor#id}
  class ActorIdInvalidError < Exception; end
end
