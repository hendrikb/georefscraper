module SocialNetwork
  module Helper
    # Represents a list of {Actor Actors} in a social network.
    # Think of it as an Array, that kind of enforces (WIP!) uniqueness of
    # {Actor Actors}
    class ActorList < Array
      # Creates instance of {ActorList} holding the {Actor actors} given in the
      # actor_array parameter. Raises {DuplicateActorError} if this given
      # actor_array contains duplicate actors.
      # Raises {InvalidActorInsertError} if one of the given actors is not of
      # class {Actor}.
      def initialize(actor_array)
        if actor_array.any? { |n| !SocialNetwork::Actor.valid?(n) }
          fail InvalidActorInsertError, 'Given invalid actor was not inserted'
        end

        if actor_array.uniq(&:id).length != actor_array.length
          fail DuplicateActorError, 'Initialization array contains duplicates'
        end

        super(actor_array)
      end

      # Adds one other {Actor} to this instance of {ActorList}. Raises a
      # {DuplicateActorError} if the other actor is already in this list.
      # @param other [Actor] The other instance to to be added to this list
      # @return [ActorList] The list plus the newly added {Actor}
      def <<(other)
        unless SocialNetwork::Actor.valid?(other)
          fail InvalidActorInsertError, "Actor #{other} is invalid"
        end

        if include?(other)
          fail DuplicateActorError, "Actor #{other} alread exists in ActorList"
        end
        super(other)
      end

      # Adds other {Actor actors} to this instance of {ActorList}. Raises a
      # {DuplicateActorError} if one of these actors is already in this list.
      # Raises {InvalidActorInsertError} if one of the given actors is not of
      # class {Actor}.
      # @param others [Actor] Other instances of {Actor} to be added to list
      # @return [ActorList] The list plus the newly added {Actor actors}
      def push(*others)
        qualify_for_insertion?(others)
        super
      end

      # Adds other {Actor actors} to this instance of {ActorList}. Raises a
      # {DuplicateActorError} if one of these actors is already in this list.
      # Raises {InvalidActorInsertError} if one of the given actors is not of
      # class {Actor}.
      # Difference to #push is, that this method basically prepends the other
      # instances of {Actor} to this list.
      # @param others [Actor] Other instances of {Actor} to be added to list
      # @return [ActorList] The list plus the newly added {Actor actors}
      def unshift(*others)
        qualify_for_insertion?(others)
        super
      end

      # Look for an {Actor} with its given {Actor#id} in this {ActorList}
      # @param id [Object] A unique id within one social network. i.e. a String
      # @return [Actor] The {Actor} with the given ID in this network or nil
      #   if it was not found
      def find_by_id(id)
        each { |actor| return actor if actor.id == id }
        nil
      end

      private

      def qualify_for_insertion?(others)
        others.each do |o|
          fail InvalidActorInsertError,
               'cant add Invalid actor' unless SocialNetwork::Actor.valid?(o)
          fail DuplicateActorError, "Actor #{o} already present" if include?(o)
        end
      end
    end

    # Exception that is raised once you've tried to add one already existing
    # {Actor} to a {ActorList}. Basically uniqueness is tried to be enforced.
    class DuplicateActorError < Exception; end

    # Exception that is raised once you've tried to add one already existing
    # {Actor} to a {ActorList}. Basically uniqueness is tried to be enforced.
    class InvalidActorInsertError < Exception; end
  end
end
