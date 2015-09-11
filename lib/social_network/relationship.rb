module SocialNetwork
  # Defines a relationship between two {Node Nodes} in a social network. A
  # relationship is defined by its {#source}, {#target} and an optional {#type}
  class Relationship
    attr_accessor :source, :target, :type

    # Create a new instance of a relationship between two actors ({Node nodes}).
    # @param source [Node] One actor that is in a relationship with another
    # @param target [Node] Another actor that is in a relationship with one
    # @param type [Object] Some relationship type specification, might be String
    def initialize(source, target, type = nil)
      if source.class != Node || target.class != Node
        fail RelationshipConnectingError, 'Provide Node as source and target'
      end

      @source = source
      @target = target
      @type = type
    end

    # Tells, wether one {Relationship} is considered equal to another
    # relationship. Equality is given, if and only if the other relationship's
    # source {Node}, the other relationship's target {Node} and the other
    # relationship's {#type} are considered equal to ours.
    # @param other [Relationship] The other relationship to compare this one to
    # @return [Boolean] true, if both relationships are considered the same
    def ==(other)
      source == other.source &&
        target == other.target &&
        type == other.type
    end

    # Provides a human readable representation of an {Relationship}
    # @return [String]
    def inspect
      "#{self.class} [#{source.id}]--#{type}--[#{target.id}]"
    end
    alias_method :to_s, :inspect
  end

  # Exception that is thrown, if either {Relationship#source} or
  # {Relationship#target} are not of type {Node} upon creating an {Relationship}
  class RelationshipConnectingError < Exception; end
end
