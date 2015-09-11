require 'spec_helper'

module SocialNetwork
  describe Relationship do
    let(:actor1) { SocialNetwork::Actor.new('n1', 't1', 'l1') }
    let(:actor2) { SocialNetwork::Actor.new('n2', 't1', 'l1') }
    let(:actor3) { SocialNetwork::Actor.new('n3', 't1', 'l1') }

    subject { SocialNetwork::Relationship.new(actor1, actor2) }
    context '.initialize' do
      it 'creates a new SocialNetwork::Relationship' do
        expect(subject).to be_kind_of SocialNetwork::Relationship
      end
      it 'sets the relationship source' do
        expect(subject.source).to eql actor1
      end

      it 'enforces a Actor as source' do
        expect { SocialNetwork::Relationship.new(nil, actor2) }
          .to raise_error SocialNetwork::RelationshipConnectingError
      end

      it 'sets the relationship target' do
        expect(subject.target).to eql actor2
      end

      it 'enforces a Actor as target' do
        expect { SocialNetwork::Relationship.new(actor1, nil) }
          .to raise_error SocialNetwork::RelationshipConnectingError
      end

      it 'allows non-typed relationship' do
        expect(subject.type).to eql nil
      end

      it 'allow any-typed relationship' do
        relationship = SocialNetwork::Relationship.new(actor1, actor2,
                                                       'testtype')
        expect(relationship.type).to eql 'testtype'
      end
    end

    context 'equality' do
      let(:ref_relationship) { SocialNetwork::Relationship.new(actor1, actor2) }
      let(:typed_ref_relationship) do
        SocialNetwork::Relationship.new(actor1, actor2, 'T')
      end

      it 'assures equality when source and target are the same' do
        equal_relationship = SocialNetwork::Relationship.new(actor1, actor2)
        expect(equal_relationship).to eq(ref_relationship)
      end

      it 'assures inequality when source and target are not the same' do
        not_equal_relationship = SocialNetwork::Relationship.new(actor1, actor3)
        expect(not_equal_relationship).not_to eq(ref_relationship)
      end

      it 'assures equality when source and target are the same' do
        equal_relationship = SocialNetwork::Relationship.new(actor1, actor2,
                                                             'T')
        expect(equal_relationship).to eq(typed_ref_relationship)
      end

      it 'assures inequality when source & target are the same, but untyped' do
        untyped_relationship = SocialNetwork::Relationship.new(actor1, actor2)
        expect(untyped_relationship).not_to eq(typed_ref_relationship)
      end
    end

    context 'human readability' do
      it 'gives proper #inspect with type' do
        subject = SocialNetwork::Relationship.new(actor1, actor2, 'T')
        expect(subject.inspect)
          .to eq 'SocialNetwork::Relationship [n1]--T--[n2]'
      end
      it 'gives proper #inspect without type' do
        subject = SocialNetwork::Relationship.new(actor1, actor2)
        expect(subject.inspect)
          .to eq 'SocialNetwork::Relationship [n1]----[n2]'
      end
      it 'gives #inspect on #to_s' do
        expect(subject.to_s).to eq subject.inspect
      end
    end
  end
end
