require 'spec_helper'

describe SocialNetwork::Parser::GraphML do
  let(:graphml_file) { File.new(File.join('spec', 'test_ref_tiny.graphml')) }
  let(:social_network) { SocialNetwork::Parser::GraphML.parse(graphml_file) }

  let(:equiv_n1) { SocialNetwork::Actor.new('n1', 'TNi', 'vonRoll') }
  let(:equiv_n2) { SocialNetwork::Actor.new('n2', 'TNi', 'Ohio') }
  let(:equiv_n3) { SocialNetwork::Actor.new('n3', 'TNp', 'Faulkner') }
  let(:equiv_n4) { SocialNetwork::Actor.new('n4', 'TNp', 'Quasha') }
  let(:equiv_n5) { SocialNetwork::Actor.new('n5', 'TNp', 'TestCannonical') }

  let(:equiv_network_actors) do
    [equiv_n1, equiv_n2, equiv_n3, equiv_n4, equiv_n5]
  end
  let(:equiv_network_rs) do
    [
      SocialNetwork::Relationship.new(equiv_n1, equiv_n2, 'TEi'),
      SocialNetwork::Relationship.new(equiv_n2, equiv_n4, 'TEf'),
      SocialNetwork::Relationship.new(equiv_n2, equiv_n5, 'TEf')
    ]
  end
  let(:equiv_network) do
    SocialNetwork::Base.new('TestNet', equiv_network_actors, equiv_network_rs)
  end

  it 'constructs a proper SocialNetwork::Base object' do
    expect(social_network).to be_kind_of(SocialNetwork::Base)
  end

  it 'constructs a proper SocialNetwork::Base object' do
    expect(social_network).to eq equiv_network
  end

  context 'parsing options' do
    it 'allows overwriting network name' do
      options = { network_name: 'other_name' }
      sn = SocialNetwork::Parser::GraphML.parse(graphml_file, options)
      expect(sn.name).to eq 'other_name'
    end
    it 'allows ommiting parsing of relationship edges' do
      options = { ommit_relationships: true }
      sn = SocialNetwork::Parser::GraphML.parse(graphml_file, options)
      expect(sn.relationships).to eq []
    end
  end

  context 'network name' do
    it 'is parsed' do
      expect(social_network.name).to eq 'TestNet'
    end
  end
  context 'network relationships' do
    it 'assigns relationships' do
      expect(social_network.relationships).to eq equiv_network_rs
    end
  end

  context 'network actors' do
    it 'assigns actors' do
      expect(social_network.actors)
        .to eq [equiv_n1, equiv_n2, equiv_n3, equiv_n4, equiv_n5]
    end

    it 'ensures actor label is a string' do
      expect(social_network.actors.first.label).to be_kind_of String
    end

    %i(id type label).each do |field|
      it "assures equality for #{field} field on parsed actor for each actor" do
        equiv_network_actors.each_with_index do |_, i|
          expect(social_network.actors[i].send(field))
            .to eq(equiv_network_actors[i].send(field))
        end
      end
    end
  end
end
