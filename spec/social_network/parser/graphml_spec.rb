require 'spec_helper'

describe SocialNetwork::Parser::GraphML do
  let(:graphml_file) { File.new(File.join('spec', 'test_ref_tiny.graphml')) }
  let(:social_network) { SocialNetwork::Parser::GraphML.parse(graphml_file) }

  let(:equiv_n1) { SocialNetwork::Node.new('n1', 'TNi', 'vonRoll') }
  let(:equiv_n2) { SocialNetwork::Node.new('n2', 'TNi', 'Ohio') }
  let(:equiv_n3) { SocialNetwork::Node.new('n3', 'TNp', 'Faulkner') }
  let(:equiv_n4) { SocialNetwork::Node.new('n4', 'TNp', 'Quasha') }

  let(:equiv_edge12) { SocialNetwork::Edge.new(equiv_n1, equiv_n2, 'TEi') }
  let(:equiv_edge24) { SocialNetwork::Edge.new(equiv_n2, equiv_n4, 'TEf') }

  let(:equiv_network_nodes) do
    [equiv_n1, equiv_n2, equiv_n3, equiv_n4]
  end
  let(:equiv_network_edges) { [equiv_edge12, equiv_edge24] }
  let(:equiv_network) do
    SocialNetwork::Base.new('TestNet', equiv_network_nodes, equiv_network_edges)
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
  context 'network edges' do
    it 'assigns edges' do
      expect(social_network.edges).to eq [equiv_edge12, equiv_edge24]
    end
  end

  context 'network nodes' do
    it 'assigns nodes' do
      expect(social_network.nodes)
        .to eq [equiv_n1, equiv_n2, equiv_n3, equiv_n4]
    end

    it 'ensures node label is a string' do
      expect(social_network.nodes.first.label).to be_kind_of String
    end

    %i(id type label).each do |field|
      it "parses node #{field}" do
        expect(social_network.nodes.first.send(field))
          .to eq equiv_n1.send(field)
      end
    end
  end
end
