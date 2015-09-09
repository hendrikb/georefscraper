module SocialNetwork
  module Parser
    # Module providing static method parse() to parse social networks from
    # GraphML
    module GraphML
      # Class providing functionality to parse GraphML social networks. It is
      # recommended to not use it directly. Use
      # SocialNetwork::Parser::GraphML.parse() instead
      class Parser
        def initialize(graphml, overwrite_network_id)
          @graphml = graphml
          @network_id = overwrite_network_id

          @doc = REXML::Document.new(@graphml)
        end

        def network
          graph_node = @doc.root.elements['graph']
          @network_id = graph_node.attributes['id'] if @network_id.nil?
          @network = SocialNetwork::Base.new(@network_id)
          parse_nodes
          parse_edges
          @network
        end

        private

        def parse_nodes
          @nodes = {}
          @doc.elements.each('*/graph/node') do |node|
            id = node.attributes['id']
            type =  node.get_text('data[@key="type"]')
            name =  node.get_text('data[@key="name"]').to_s
            node_object = SocialNetwork::Node.new id, type, name
            @nodes[id] = node_object
            @network.nodes << node_object
          end
        end

        def parse_edges
          @doc.elements.each('*/graph/edge') do |edge|
            source = @nodes[edge.attributes['source']]
            target = @nodes[edge.attributes['target']]
            type =  edge.get_text('data[@key="type"]')
            edge_object = SocialNetwork::Edge.new source, target, type
            @network.edges << edge_object
          end
        end
      end
      def self.parse(graphml, overwrite_id = nil)
        SocialNetwork::Parser::GraphML::Parser.new(graphml, overwrite_id)
          .network
      end
    end
  end
end
