module SocialNetwork
  module Helper
    # Represents a list of {Relationship Relationships} in a social network.
    # Think of it as an Array, that kind of enforces (WIP!) uniqueness of
    # {Relationship Relationships}
    class RelationshipList < Array
      # Creates an instance of {RelationshipList} holding the {Relationship}s}
      # given in the relationship_array parameter. Raises
      # {DuplicateRelationshipError} if this given relationship_array contains
      # duplicate relationships.Raises {InvalidRelationshipInsertError} if one
      # of the given relationships is not of class {Relationship}.
      def initialize(relationship_array)
        if relationship_array.each do |e|
          unless valid?(e)
            fail InvalidRelationshipInsertError,
                 "Cannot insert invalid Relationship #{e}"
          end
        end
        end
        super
      end

      # Adds one other {Relationship} to this instance of {RelationshipList}.
      # Raises a {DuplicateRelationshipError} if the other relationship is
      # already in this list.
      # @param other [Relationship] The other relationship instance to be added
      # @return [RelationshipList] The list plus the newly added {Relationship}
      def <<(other)
        fail InvalidRelationshipInsertError,
             "#{other} is no  Relationship" unless valid?(other)
        fail DuplicateRelationshipError,
             "#{other} already present" if include?(other)
        super
      end

      # Adds multiple other {Relationship relationships} to this instance of
      # {RelationshipList}. Raises a {DuplicateRelationshipError} if one of
      # these relationships is already in this list. Raises
      # {InvalidRelationshipInsertError} if one of the given relationships is
      # not ofclass {Relationship}.
      # @param others [Relationship] Instances of {Relationship} to be added
      # @return [RelationshipList] The list and the newly added {Relationship}s
      def push(*others)
        qualify_for_insertion?(others)
        super
      end

      # Adds multiple other {Relationship relationships} to this instance of
      # {RelationshipList}. Raises a {DuplicateRelationshipError} if one of
      # these relationships is already in this list. Raises
      # {InvalidRelationshipInsertError} if one of the given relationships is
      # not of class {Relationship}. Difference to #push is, that this method
      # basically prepends the other instances of {Relationship} to this list.
      # @param others [Relationship] Other instances of {Relationship} to add
      # @return [RelationshipList] The list and the newly added {Relationship}s
      def unshift(*others)
        qualify_for_insertion?(others)
        super
      end

      private

      def valid?(relationship)
        relationship.class == SocialNetwork::Relationship
      end

      def qualify_for_insertion?(others)
        others.each do |o|
          fail InvalidRelationshipInsertError,
               "can't add invalid relationship" unless valid?(o)
          fail DuplicateRelationshipError,
               'Relationship already present' if include?(o)
        end
      end
    end

    # This gets raised if you've tried to add an {Relationship} more than once
    # to an {RelationshipList}
    class DuplicateRelationshipError < Exception; end

    # This gets raised if you've tried to add something, that is no Relationship
    class InvalidRelationshipInsertError < Exception; end
  end
end
