require 'spec_helper'

module SocialNetwork
  describe Node do
    subject { SocialNetwork::Node.new('testid', 'testtype', 'testlabel') }
    context '.initialize' do
      it 'creates a new SocialNetwork::Node' do
        expect(subject).to be_kind_of SocialNetwork::Node
      end
      it 'sets the node id' do
        expect(subject.id).to eql 'testid'
      end
      it 'failes if empty node id is given' do
        expect { SocialNetwork::Node.new('', 't', 't') }
          .to raise_error SocialNetwork::NodeIdInvalidError
      end
      it 'failes if nil node id is given' do
        expect { SocialNetwork::Node.new(nil, 't', 't') }
          .to raise_error SocialNetwork::NodeIdInvalidError
      end
      it 'sets the node type' do
        expect(subject.type).to eql 'testtype'
      end
      it 'sets the node label' do
        expect(subject.label).to eql 'testlabel'
      end
    end

    context 'equality' do
      let(:ref_node) do
        SocialNetwork::Node.new('testid', 'testtype', 'testlbl')
      end

      it 'assures equality when id param is the same' do
        equal_node = SocialNetwork::Node.new('testid', 'testtype', 'testlbl')
        expect(equal_node).to eq(ref_node)
      end

      it 'assures inequality when id param mismatches' do
        non_equal_node = SocialNetwork::Node.new('other', 'testtype', 'testlbl')
        expect(non_equal_node).not_to eq(ref_node)
      end
    end

    context 'human readability' do
      it 'gives proper #inspect' do
        expect(subject.inspect).to eq 'SocialNetwork::Node[testid] "testlabel"'
      end
      it 'gives #inspect on #to_s' do
        expect(subject.to_s).to eq subject.inspect
      end
    end
  end
end
