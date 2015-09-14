require 'htmlentities'

module SocialNetwork
  module Parser
    # Module providing static method parse() to parse social networks from
    # GraphML
    module GraphML
      # Class providing functionality to parse GraphML social networks. It is
      # recommended to not use it directly. Use
      # SocialNetwork::Parser::GraphML.parse() instead
      class Parser
        def initialize(graphml, options = {})
          @graphml = graphml
          @options = options
          @network_id = options[:network_name]

          @doc = REXML::Document.new(@graphml)
        end

        # @return [SocialNetwork::Base] instance that was parsed from GraphML
        def network
          graph_actor = @doc.root.elements['graph']
          @network_id = graph_actor.attributes['id'] if @network_id.nil?
          @network = SocialNetwork::Base.new(@network_id)
          parse_actors
          parse_relationships unless @options[:ommit_relationships]
          @network
        end

        private

        def parse_actors
          @actors = {}
          @doc.elements.each('*/graph/node') do |actor|
            id = actor.attributes['id']
            type = actor.get_text('data[@key="type"]')
            name = parse_name_for(actor)
            actor_object = SocialNetwork::Actor.new id, type, name
            @actors[id] = actor_object
            @network.push_actor actor_object
          end
        end

        def parse_name_for(actor)
          n = actor.get_text('data[@key="name"]').to_s
          n = actor.get_text('data[@key="canonicalName"]').to_s if n.empty?
          HTMLEntities.new.decode(n)
        end

        def parse_relationships
          @doc.elements.each('*/graph/edge') do |relationship|
            source = @actors[relationship.attributes['source']]
            target = @actors[relationship.attributes['target']]
            type = relationship.get_text('data[@key="type"]')
            relationship_object = SocialNetwork::Relationship.new(
              source, target, type)
            @network.push_relationship relationship_object
          end
        end
      end

      # Parses a GraphML file and tries to render a {SocialNetwork::Base} social
      # network} from it.
      # @return [SocialNetWork::Base] Social Network parsed from the GraphML
      # @param graphml [String] File name to a graphml file
      # @param options [Hash] Options Hash
      def self.parse(graphml, options = {})
        SocialNetwork::Parser::GraphML::Parser.new(graphml, options).network
      end
    end
  end
end
