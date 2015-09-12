module SocialNetwork
  module Converter
    # A module that provides functionality to convert a social network into a
    # list of {SocialNetwork::Actor actors}
    module NodeList
      # This just returns the {SocialNetwork::Base#actors}
      # {SocialNetwork::Helpers::ActorList acor list} of a given social network
      # @param social_network [SocialNetwork::Base] Network to getactors from
      # @param _options [Hash] currently unused
      # @return [SocialNetwork::Helpers::ActorList] List of actor instances
      def self.convert(social_network, _options = {})
        social_network.actors
      end
    end
  end
end
