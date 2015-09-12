require 'spec_helper'

module SocialNetwork
  describe Actor do
    subject { SocialNetwork::Actor.new('testid', 'testtype', 'testlabel') }
    context '.initialize' do
      it 'creates a new SocialNetwork::Actor' do
        expect(subject).to be_kind_of SocialNetwork::Actor
      end
      it 'sets the actor id' do
        expect(subject.id).to eql 'testid'
      end

      it 'sets the actor label' do
        expect(subject.label).to eql 'testlabel'
      end
      it 'fails if empty actor id is given' do
        expect { SocialNetwork::Actor.new('', 't', 't') }
          .to raise_error SocialNetwork::ActorIdInvalidError
      end
      it 'fails if nil actor id is given' do
        expect { SocialNetwork::Actor.new(nil, 't', 't') }
          .to raise_error SocialNetwork::ActorIdInvalidError
      end
      it 'freezes the actor id' do
        expect(subject.id.frozen?).to be true
      end
      it 'sets the actor type' do
        expect(subject.type).to eql 'testtype'
      end
      it 'sets the actor label' do
        expect(subject.label).to eql 'testlabel'
      end
      it 'sanitizes the label' do
        subject.label = 'Test U.K. entry'
        expect(subject.label).to eql 'Test United Kingdom entry'
      end
    end

    context 'equality' do
      let(:ref_actor) do
        SocialNetwork::Actor.new('testid', 'testtype', 'testlbl')
      end

      it 'assures equality when id param is the same' do
        equal_actor = SocialNetwork::Actor.new('testid', 'testtype', 'testlbl')
        expect(equal_actor).to eq(ref_actor)
      end

      it 'assures inequality when id param mismatches' do
        non_equal_actor = SocialNetwork::Actor.new('other', 'testtype',
                                                   'testlbl')
        expect(non_equal_actor).not_to eq(ref_actor)
      end
    end

    context 'human readability' do
      it 'gives proper #inspect' do
        expect(subject.inspect).to eq 'SocialNetwork::Actor[testid] "testlabel"'
      end
      it 'gives #inspect on #to_s' do
        expect(subject.to_s).to eq subject.inspect
      end
    end
  end
end
