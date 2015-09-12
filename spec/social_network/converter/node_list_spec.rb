require 'spec_helper'

describe SocialNetwork::Converter::NodeList do
  it 'responds to module method convert' do
    expect(SocialNetwork::Converter::NodeList).to respond_to(:convert)
      .with(2).arguments
  end
  it 'returns only the nodes of the given network' do
    me = SocialNetwork::Actor.new('n1', 'tP', 'Hendrik')
    mum = SocialNetwork::Actor.new('n2', 'tP', 'Mum')
    dad = SocialNetwork::Actor.new('n3', 'tP', 'Dad')

    relationship_married = SocialNetwork::Relationship.new(mum, dad, 'married')
    relationship_f_son = SocialNetwork::Relationship.new(dad, me, 'son')
    relationship_m_son = SocialNetwork::Relationship.new(mum, me, 'son')

    actor_list = SocialNetwork::Helper::ActorList.new([me, mum, dad])
    relationship_list = SocialNetwork::Helper::RelationshipList.new(
      [relationship_married, relationship_f_son, relationship_m_son])

    network = SocialNetwork::Base.new('Test', actor_list, relationship_list)

    expect(SocialNetwork::Converter::NodeList.convert(network)).to eq actor_list
  end
end
