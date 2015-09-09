require 'spec_helper'

module SocialNetwork
  describe Edge do
    let(:node1) { SocialNetwork::Node.new('n1', 't1', 'l1') }
    let(:node2) { SocialNetwork::Node.new('n2', 't1', 'l1') }
    let(:node3) { SocialNetwork::Node.new('n3', 't1', 'l1') }

    subject { SocialNetwork::Edge.new(node1, node2) }
    context '.initialize' do
      it 'creates a new SocialNetwork::Edge' do
        expect(subject).to be_kind_of SocialNetwork::Edge
      end
      it 'sets the edge source' do
        expect(subject.source).to eql node1
      end

      it 'enforces a Node as source' do
        expect { SocialNetwork::Edge.new(nil, node2) }
          .to raise_error SocialNetwork::EdgeConnectingError
      end

      it 'sets the edge target' do
        expect(subject.target).to eql node2
      end

      it 'enforces a Node as target' do
        expect { SocialNetwork::Edge.new(node1, nil) }
          .to raise_error SocialNetwork::EdgeConnectingError
      end

      it 'allows non-typed edge' do
        expect(subject.type).to eql nil
      end

      it 'allow any-typed edge' do
        edge = SocialNetwork::Edge.new(node1, node2, 'testtype')
        expect(edge.type).to eql 'testtype'
      end
    end

    context 'equality' do
      let(:ref_edge) { SocialNetwork::Edge.new(node1, node2) }
      let(:typed_ref_edge) { SocialNetwork::Edge.new(node1, node2, 'T') }

      it 'assures equality when source and target are the same' do
        equal_edge = SocialNetwork::Edge.new(node1, node2)
        expect(equal_edge).to eq(ref_edge)
      end

      it 'assures inequality when source and target are not the same' do
        not_equal_edge = SocialNetwork::Edge.new(node1, node3)
        expect(not_equal_edge).not_to eq(ref_edge)
      end

      it 'assures equality when source and target are the same' do
        equal_edge = SocialNetwork::Edge.new(node1, node2, 'T')
        expect(equal_edge).to eq(typed_ref_edge)
      end

      it 'assures inequality when source & target are the same, but untyped' do
        untyped_edge = SocialNetwork::Edge.new(node1, node2)
        expect(untyped_edge).not_to eq(typed_ref_edge)
      end
    end

    context 'human readability' do
      it 'gives proper #inspect with type' do
        subject = SocialNetwork::Edge.new(node1, node2, 'T')
        expect(subject.inspect).to eq 'SocialNetwork::Edge [n1]--T--[n2]'
      end
      it 'gives proper #inspect without type' do
        subject = SocialNetwork::Edge.new(node1, node2)
        expect(subject.inspect).to eq 'SocialNetwork::Edge [n1]----[n2]'
      end
      it 'gives #inspect on #to_s' do
        expect(subject.to_s).to eq subject.inspect
      end
    end
  end
end
