require 'rexml/document'

module SocialNetwork
  # Represents a social network with all its {Node Nodes} (actors) and
  # {Edge Edges} (relationships between actors)
  class Base
    attr_accessor :name, :nodes, :edges

    def initialize(name,
                   nodes = Helper::NodeList.new([]),
                   edges = Helper::EdgeList.new([]))
      @name = name || fail(NameMissingError,
                           'Please provide a name for the social network')
      @nodes = nodes
      @edges = edges
    end

    # Compare SocialNetwork instances to each other.
    # A social network is considered the same, if all nodes and all edges are
    # exactly the same. Note that the #name is not considered for equality!
    def ==(other)
      nodes == other.nodes && edges == other.edges
    end

    # Provide a human readable representation for the Social Network
    def inspect
      "#{self.class}[#{name}] - Nodes: #{nodes.count} Edges: #{edges.count}"
    end
  end

  # Exception that is thrown, if one forgot to give the new social net a name
  class NameMissingError < Exception; end
end
