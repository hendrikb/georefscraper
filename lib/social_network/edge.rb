module SocialNetwork
  # Defines a relationship between two Nodes in a social network
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

    def ==(other)
      source == other.source &&
        target == other.target &&
        type == other.type
    end

    def inspect
      "#{self.class} [#{source.id}]--#{type}--[#{target.id}]"
    end
    alias_method :to_s, :inspect
  end

  class EdgeConnectingError < Exception; end
end
