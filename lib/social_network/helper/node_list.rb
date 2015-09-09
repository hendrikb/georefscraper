module SocialNetwork
  module Helper
    class NodeList < Array
      def initialize(node_array)
        if node_array.uniq(&:id).length != node_array.length
          fail DuplicateNodeError, 'Initialization array contains duplicates'
        end
        super(node_array)
      end

      def include?(other)
        self.any? { |n| n == other }
      end

      def <<(other)
        if include?(other)
          fail DuplicateNodeError, 'Node ID  alread exists in NodeList'
        end
        super(other)
      end

      def push(*others)
        fail DuplicateNodeError, 'Node Exists' if others.any? do |other|
          self.include? other
        end
        super
      end

      def unshift(*others)
        fail DuplicateNodeError, 'Node Exists' if others.any? do |other|
          self.include? other
        end
        super
      end
    end

    class DuplicateNodeError < Exception; end
  end
end
