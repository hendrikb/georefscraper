require 'rexml/document'

module SocialNetwork
  # Represents a social network with all its {Node Nodes} (actors) and
  # {Edge Edges} (relationships between actors)
  class Base
    attr_accessor :name

    def initialize(name,
                   nodes = Helper::NodeList.new([]),
                   edges = Helper::EdgeList.new([]))
      @name = name || fail(NameMissingError,
                           'Please provide a name for the social network')
      @nodes = nodes
      @edges = edges
    end

    # @return [SocialNetwork::Helper::NodeList] List of nodes in this network
    def nodes
      @nodes.dup.freeze
    end

    # Pushes one new node to this social network instance
    # @param node [Node] The new node in this network, not linked via {Edge} now
    def push_node(node)
      @nodes << node
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

  # Exception that is thrown, if one tries to modify the {Base#nodes} directl.
  # Please use {Base#push_node} instead!
  class NodeAccessError < Exception; end
end
