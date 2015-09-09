module SocialNetwork
  module Helper
    # Represents a list of {Node Nodes} in a social network.
    # Think of it as an Array, that kind of enforces (WIP!) uniqueness of
    # {Node Nodes}
    class NodeList < Array
      # Creates an instance of {NodeList} holding the {Node nodes} given in the
      # node_array parameter. Raises {DuplicateNodeError} if this given
      # node_array contains duplicate nodes.
      def initialize(node_array)
        if node_array.uniq(&:id).length != node_array.length
          fail DuplicateNodeError, 'Initialization array contains duplicates'
        end
        super(node_array)
      end

      # Checks if the given {Node} is already existent in this instance of
      # {NodeList}
      # @param other [Node} The other {Node} that's supposed to looked for here
      # @return [Boolean] whether or not the other {Node} is already in here
      def include?(other)
        self.any? { |n| n == other }
      end

      # Adds one other {Node} to this instance of {NodeList}. Raises a
      # {DuplicateNodeError} if the other node is already in this list.
      # @param other [Node] The other instance to to be added to this list
      # @return [NodeList] The list plus the newly added {Node}
      def <<(other)
        if include?(other)
          fail DuplicateNodeError, 'Node ID  alread exists in NodeList'
        end
        super(other)
      end

      # Adds multiple other {Node nodes} to this instance of {NodeList}. Raises
      # a {DuplicateNodeError} if one of these nodes is already in this list.
      # @param others [Node] Other instances of {Node} to be added to this list
      # @return [NodeList] The list plus the newly added {Node nodes}
      def push(*others)
        fail DuplicateNodeError, 'Node Exists' if others.any? do |other|
          self.include? other
        end
        super
      end

      # Adds multiple other {Node nodes} to this instance of {NodeList}. Raises
      # a {DuplicateNodeError} if one of these nodes is already in this list.
      # Difference to #push is, that this method basically prepends the other
      # instances of {Node} to this list.
      # @param others [Node] Other instances of {Node} to be added to this list
      # @return [NodeList] The list plus the newly added {Node nodes}
      def unshift(*others)
        fail DuplicateNodeError, 'Node Exists' if others.any? do |other|
          self.include? other
        end
        super
      end
    end

    # Exception that is raised once you've tried to add one already existing
    # {Node} to a {NodeList}. Basically uniqueness is tried to be enforced.
    class DuplicateNodeError < Exception; end
  end
end
