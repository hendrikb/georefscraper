module SocialNetwork
  module Helper
    # Represents a list of {Edge Edges} in a social network.
    # Think of it as an Array, that kind of enforces (WIP!) uniqueness of
    # {Edge Edges}
    class EdgeList < Array
    end

    # This gets raised if you've tried to add an edge more than once to an
    # {EdgeList}
    class DuplicateEdgeError < Exception; end
  end
end
