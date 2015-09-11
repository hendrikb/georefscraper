require 'spec_helper'

describe SocialNetwork::Parser::GraphML do
  let(:graphml_file) { File.new(File.join('spec', 'test_ref_tiny.graphml')) }
  let(:social_network) { SocialNetwork::Parser::GraphML.parse(graphml_file) }

  let(:equiv_n1) { SocialNetwork::Node.new('n1', 'TNi', 'vonRoll') }
  let(:equiv_n2) { SocialNetwork::Node.new('n2', 'TNi', 'Ohio') }
  let(:equiv_n3) { SocialNetwork::Node.new('n3', 'TNp', 'Faulkner') }
  let(:equiv_n4) { SocialNetwork::Node.new('n4', 'TNp', 'Quasha') }
  let(:equiv_n5) { SocialNetwork::Node.new('n5', 'TNp', 'TestCannonical') }

  let(:equiv_network_nodes) do
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
    SocialNetwork::Base.new('TestNet', equiv_network_nodes, equiv_network_rs)
  end

  it 'constructs a proper SocialNetwork::Base object' do
    expect(social_network).to be_kind_of(SocialNetwork::Base)
  end

  it 'constructs a proper SocialNetwork::Base object' do
    expect(social_network).to eq equiv_network
  end

  context 'network name' do
    it 'is parsed' do
      expect(social_network.name).to eq 'TestNet'
    end

    it 'can be overriden' do
      sn = SocialNetwork::Parser::GraphML.parse(graphml_file, 'other_id')
      expect(sn.name).to eq 'other_id'
    end
  end
  context 'network relationships' do
    it 'assigns relationships' do
      expect(social_network.relationships).to eq equiv_network_rs
    end
  end

  context 'network nodes' do
    it 'assigns nodes' do
      expect(social_network.nodes)
        .to eq [equiv_n1, equiv_n2, equiv_n3, equiv_n4, equiv_n5]
    end

    it 'ensures node label is a string' do
      expect(social_network.nodes.first.label).to be_kind_of String
    end

    %i(id type label).each do |field|
      it "assures equality for #{field} field on parsed node for each node" do
        equiv_network_nodes.each_with_index do |_, i|
          expect(social_network.nodes[i].send(field))
            .to eq(equiv_network_nodes[i].send(field))
        end
      end
    end
  end
end
