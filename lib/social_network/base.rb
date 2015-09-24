require 'rexml/document'

module SocialNetwork
  # Represents a social network with all its {Actor Actors} (actors) and
  # {Relationship Relationships} (relationships between actors)
  class Base
    attr_accessor :name, :options

    # Create a new instance of {Base}, which basically represents a social
    # network with actors (instances of {Actor}) in a {Helper::ActorList} and
    # relationships between them, instances of {Relationship} in an
    # Helper::RelationshipList}
    # @param name [String] A human readable name, e.g. "Family"
    # @param actors [ActorList] List of actors in the social network
    # @param relationships [RelationshipList] Relationships between actors
    # @param options [Hash] Options hash, currently unused
    # @return [Base] Instance of a social network
    def initialize(name,
                   actors = Helper::ActorList.new([]),
                   relationships = Helper::RelationshipList.new([]),
                   options = {})
      @name = name || fail(NameMissingError,
                           'Please provide a name for the social network')
      @actors = actors
      @relationships = relationships
      @options = options
    end

    # @return [SocialNetwork::Helper::ActorList] List of actors in this network
    def actors
      @actors.dup.freeze
    end

    # Pushes one new actor to this social network instance
    # @param actor [Actor] New unlinked actor for the network
    def push_actor(actor)
      @actors << actor
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
    # Social networks are considered same, if all actors and relationships are
    # the same. Note that the #name is not considered for equality!
    # @note See {Actor} for definitiion of their equality, since it's considered
    # @note See {Relationship} for definitiion of their equality, also.
    def ==(other)
      actors == other.actors && relationships == other.relationships
    end

    # Provide a human readable representation for the Social Network
    def inspect
      "#{self.class}[#{name}] - Actors: #{actors.count}" \
        " Relationships: #{relationships.count}"
    end

    # Giving Neighbors of given {Actor} in this instance of the social network
    # @param actor [Actor] Given actor to check who is connected to it
    # @return [SocialNetwork::Helper::ActorList] List of actors connected to
    #    the given one
    def neighbors_of(actor)
      neighbors = SocialNetwork::Helper::ActorList.new([])
      @relationships.each do |rel|
        neighbors << rel.source if rel.target == actor
        neighbors << rel.target if rel.source == actor
      end
      neighbors
    end
  end

  # Exception that is thrown, if one forgot to give the new social net a name
  class NameMissingError < Exception; end
end
