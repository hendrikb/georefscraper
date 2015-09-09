module SocialNetwork
  # Represents some kind of actor in a social network
  class Node
    attr_accessor :id, :type, :label

    # @param id [Object] A unique id within one social network. i.e. a String
    # @param type [Object] Some identifier for this type of node, i.e. a String
    # @param label [String] A human readble name for this {Node}
    def initialize(id, type, label)
      if id.nil? || id.empty?
        fail NodeIdInvalidError, 'Node id must not be empty nor nil'
      end

      @id = id.freeze
      @type = type
      @label = label
    end

    # Tells whether this instance of a {Node} is equal to another. Equality is
    # defined by equality of {Node#id their ids} only!
    # @param other [Node] The other node to compare this instance against
    # @return [Boolean] True if both {Node#id node ids} are the same.
    def ==(other)
      id == other.id
    end

    # Provide a human readable name for a {Node} in a social network
    # @return [String] Human readable name
    def inspect
      "#{self.class}[#{id}] \"#{label}\""
    end

    alias_method :to_s, :inspect
  end

  # This Exceptio gets raised if you've tried to initialize a {Node} with a nil
  # or empty {Node#id}
  class NodeIdInvalidError < Exception; end
end
