module SocialNetwork
  module Helper
    # Represents a list of {Edge Edges} in a social network.
    # Think of it as an Array, that kind of enforces (WIP!) uniqueness of
    # {Edge Edges}
    class EdgeList < Array
      # Creates an instance of {EdgeList} holding the {Edge edges} given in the
      # edge_array parameter. Raises {DuplicateEdgeError} if this given
      # edge_array contains duplicate edges.
      # Raises {InvalidEdgeInsertError} if one of the given edges is not of
      # class {Edge}.
      def initialize(edge_array)
        if edge_array.each do |e|
          unless valid?(e)
            fail InvalidEdgeInsertError, "Cannot insert invalid Edge #{e}"
          end
        end
        end
        super
      end

      # Adds one other {Edge} to this instance of {EdgeList}. Raises a
      # {DuplicateEdgeError} if the other edge is already in this list.
      # @param other [Edge] The other edge instance to be added to this list
      # @return [EdgeList] The list plus the newly added {Edge}
      def <<(other)
        fail InvalidEdgeInsertError, "#{other} is no  Edge" unless valid?(other)
        fail DuplicateEdgeError, "#{other} already present" if include?(other)
        super
      end

      # Adds multiple other {Edge edges} to this instance of {EdgeList}. Raises
      # a {DuplicateEdgeError} if one of these edges is already in this list.
      # Raises {InvalidEdgeInsertError} if one of the given edges is not of
      # class {Edge}.
      # @param others [Edge] Other instances of {Edge} to be added to this list
      # @return [EdgeList] The list plus the newly added {Edge edges}
      def push(*others)
        qualify_for_insertion?(others)
        super
      end

      # Adds multiple other {Edge edges} to this instance of {EdgeList}. Raises
      # a {DuplicateEdgeError} if one of these edges is already in this list.
      # Raises {InvalidEdgeInsertError} if one of the given edges is not of
      # class {Edge}.
      # Difference to #push is, that this method basically prepends the other
      # instances of {Edge} to this list.
      # @param others [Edge] Other instances of {Edge} to be added to this list
      # @return [EdgeList] The list plus the newly added {Edge edges}
      def unshift(*others)
        qualify_for_insertion?(others)
        super
      end

      private

      def valid?(edge)
        edge.class == SocialNetwork::Edge
      end

      def qualify_for_insertion?(others)
        others.each do |o|
          fail InvalidEdgeInsertError, "can't add invalid edge" unless valid?(o)
          fail DuplicateEdgeError, 'Edge already present' if include?(o)
        end
      end
    end

    # This gets raised if you've tried to add an {Edge} more than once to an
    # {EdgeList}
    class DuplicateEdgeError < Exception; end

    # This gets raised if you've tried to add something, that is not an {Edge}
    class InvalidEdgeInsertError < Exception; end
  end
end
