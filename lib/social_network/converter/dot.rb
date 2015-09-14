module SocialNetwork
  # Holds classes, that are able to convert social networks to other formats
  # (e.g. DOT file format)
  module Converter
    # Module providing static method #convert to convert social networks to
    # {http://www.graphviz.org/ graphviz'} DOT file format
    module Dot
      # Class providing functionality to convert social networks to GraphML.
      # It'srecommended to not use it directly. Use
      # #convert instead
      class Converter
        # param social_network [SocialNetwork::Base] a social network to convert
        def initialize(social_network)
          @sn = social_network
        end

        # Runs the convert process towards a DOT file output
        # @return [String} A string representation of a social network in DOT
        def convert
          @dot = "graph \"#{@sn.name.delete('"')}\" {\n"
          write_actors
          write_relationships
          @dot << "}  // drop this code into a graphviz tool, like so:\n"
          @dot << "   //   dot -Tpng -ograph.png test.dot\n"
        end

        private

        def write_actors
          @sn.actors.each do |actor|
            color = fillcolor_for(actor)
            @dot << "\t\"#{actor.id}\" " \
              "[style=filled fillcolor=#{color} " \
             "label=\"#{actor.label.delete('"')}\"]\n"
          end
        end

        def fillcolor_for(actor)
          case actor.class.to_s
          when 'SocialNetwork::Person'
            return 'orange'
          when 'SocialNetwork::Organization'
            return 'orangered'
          else
            return 'white'
          end
        end

        def write_relationships
          @sn.relationships.each do |relationship|
            @dot << "\t\"#{relationship.source.id}\" -- " \
              "\"#{relationship.target.id}\";\n"
          end
        end
      end

      # Converts the given social network to the DOT file format
      # @param social_network [SocialNetwork::Base] A Network to convert to DOT
      # @param _options [Hash] Currently unused options
      # @return [String] A string representation of the Social network in DOT
      def self.convert(social_network, _options = {})
        Converter.new(social_network).convert
      end
    end
  end
end
