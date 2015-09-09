module SocialNetwork
  # Defines a relationship between two {Node Nodes} in a social network. A
  # relationship is defined by its {#source}, {#target} and an optional {#type}
  class Edge
    attr_accessor :source, :target, :type

    def initialize(source, target, type = nil)
      if source.class != Node || target.class != Node
        fail EdgeConnectingError, 'Provide Node as source and target'
      end

      @source = source
      @target = target
      @type = type
    end

    # Tells, wether one {Edge} is considered equal to another edge. Equality is
    # given, if and only if the other edge's source {Node}, the other edge's
    # target {Node} and the other edge's {#type} are considered equal to ours.
    # @return [Boolean]
    def ==(other)
      source == other.source &&
        target == other.target &&
        type == other.type
    end

    # Provides a human readable representation of an {Edge}
    # @return [String]
    def inspect
      "#{self.class} [#{source.id}]--#{type}--[#{target.id}]"
    end
    alias_method :to_s, :inspect
  end

  # Exception that is thrown, if either {Edge#source} or {Edge#target} are not
  # of type {Node} upon creating an {Edge}
  class EdgeConnectingError < Exception; end
end
