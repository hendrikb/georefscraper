module SocialNetwork
  # Represents some kind of actor in a social network
  class Node
    attr_accessor :id, :type, :label

    def initialize(id, type, label)
      if id.nil? || id.empty?
        fail NodeIdInvalidError, 'Node id must not be empty nor nil'
      end

      @id = id
      @type = type
      @label = label
    end

    def ==(other)
      id == other.id
    end

    def inspect
      "#{self.class}[#{id}] \"#{label}\""
    end

    alias_method :to_s, :inspect
  end

  class NodeIdInvalidError < Exception; end
end
