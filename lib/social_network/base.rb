require 'rexml/document'

module SocialNetwork
  # Represents a social network with all its {Node Nodes} (actors) and
  # {Relationship Relationships} (relationships between actors)
  class Base
    attr_accessor :name

    # Create a new instance of {Base}, which basically represents a social
    # network with actors (instances of {Node}) in a {Helper::NodeList} and
    # relationships between them, instances of {Relationship} in an
    # Helper::RelationshipList}
    # @param name [String] A human readable name, e.g. "Family"
    # @param nodes [NodeList] List of actors in the social network
    # @param relationships [RelationshipList] Relationships between actors
    # @return [Base] Instance of a social network
    def initialize(name,
                   nodes = Helper::NodeList.new([]),
                   relationships = Helper::RelationshipList.new([]))
      @name = name || fail(NameMissingError,
                           'Please provide a name for the social network')
      @nodes = nodes
      @relationships = relationships
    end

    # @return [SocialNetwork::Helper::NodeList] List of nodes in this network
    def nodes
      @nodes.dup.freeze
    end

    # Pushes one new node to this social network instance
    # @param node [Node] New unlinked node for the network
    def push_node(node)
      @nodes << node
    end

    # @return [SocialNetwork::Helper::RelationshipList] List of {Relationship}s
    def relationships
      @relationships.dup.freeze
    end

    # Pushes new relationship ({Relationship}) to this social network instance
    # @param relationship [Relationship] The new {Relationship} in this network
    def push_relationship(relationship)
      @relationships << relationship
    end

    # Compare SocialNetwork instances to each other.
    # Social networks are considered same, if all nodes and relationships are
    # the same. Note that the #name is not considered for equality!
    # @note See {Node} for definitiion of their equality, since it's considered
    # @note See {Relationship} for definitiion of their equality, also.
    def ==(other)
      nodes == other.nodes && relationships == other.relationships
    end

    # Provide a human readable representation for the Social Network
    def inspect
      "#{self.class}[#{name}] - Nodes: #{nodes.count}" \
               " Relationships: #{relationships.count}"
    end
  end

  # Exception that is thrown, if one forgot to give the new social net a name
  class NameMissingError < Exception; end
end
