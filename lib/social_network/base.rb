require 'rexml/document'

module SocialNetwork
  # Represents a social network with all its nodes (actors) and edges
  # (relationships between actors)
  class Base
    attr_accessor :name, :nodes, :edges

    def initialize(name,
                   nodes = Helper::NodeList.new,
                   edges = Helper::EdgeList.new)
      @name = name || fail(NameMissingError,
                           'Please provide a name for the social network')
      @nodes = nodes
      @edges = edges
    end

    def ==(other)
      nodes == other.nodes && edges == other.edges
    end

    def inspect
      "#{self.class}[#{name}] - Nodes: #{nodes.count} Edges: #{edges.count}"
    end
  end

  class NameMissingError < Exception; end
end
