require 'spec_helper'
describe SocialNetwork::Helper::ActorList do
  let(:actor1) { SocialNetwork::Actor.new('testid', 't1', 'l1') }
  let(:actor1_dup) { SocialNetwork::Actor.new('testid', 't1', 'l2') }
  let(:actor2) { SocialNetwork::Actor.new('testid2', 't1', 'l3') }
  let(:actor3) { SocialNetwork::Actor.new('testid3', 't1', 'l3') }
  let(:actor4) { SocialNetwork::Actor.new('testid4', 't1', 'l3') }
  let(:invalid_actor) { nil }
  let(:organizational_actor) do
    SocialNetwork::Organization.new('to1', 'to', 'Organization 1')
  end
  let(:personal_actor) { SocialNetwork::Person.new('tp1', 'tp', 'Person') }

  subject { SocialNetwork::Helper::ActorList.new([actor1, actor2]) }

  it 'adds appropriate number of actors' do
    expect(subject.length).to eq 2
  end

  it 'adds correct actors - and only them' do
    expect(subject).to eq [actor1, actor2]
  end

  it 'prevents duplicate actors on initialization' do
    expect do
      SocialNetwork::Helper::ActorList
        .new([actor1, actor2, actor1_dup])
    end
      .to raise_error SocialNetwork::Helper::DuplicateActorError
  end

  it 'prevents insertion of something different than Actor or subclasses' do
    expect do
      SocialNetwork::Helper::ActorList
        .new([actor1, invalid_actor, actor2])
    end
      .to raise_error SocialNetwork::Helper::InvalidActorInsertError
  end

  it 'can add actor subclasses, though' do
    expect do
      SocialNetwork::Helper::ActorList
        .new([actor1, personal_actor, organizational_actor])
    end.not_to raise_error
  end

  context '#include?' do
    it 'returns true if object with same id is present' do
      expect(subject.include?(actor1_dup)).to be true
    end
    it 'returns false if object with new id is not present' do
      expect(subject.include?(actor3)).to be false
    end
  end
  context 'adding objects' do
    context '#<<' do
      it 'adds non duplicate actor to actor list' do
        expect(subject << actor3)
          .to eq SocialNetwork::Helper::ActorList.new([actor1, actor2, actor3])
      end
      it 'prevents adding a duplicate actor' do
        expect { subject << actor1_dup }
          .to raise_error SocialNetwork::Helper::DuplicateActorError
      end
      it 'prevents insertion of something different than Actor' do
        expect { subject << invalid_actor }
          .to raise_error SocialNetwork::Helper::InvalidActorInsertError
      end
      it 'can add actor subclasses, though' do
        expect { subject << organizational_actor }
          .not_to raise_error
      end
    end
    context '#push' do
      it 'adds non duplicate actor to actor list' do
        expect(subject.push(actor3, actor4))
          .to eq SocialNetwork::Helper::ActorList.new([actor1, actor2, actor3,
                                                       actor4])
      end
      it 'prevents adding a duplicate actor' do
        expect { subject.push(actor1_dup) }
          .to raise_error SocialNetwork::Helper::DuplicateActorError
      end
      it 'prevents insertion of something different than Actor' do
        expect { subject.push([actor1, invalid_actor, actor2]) }
          .to raise_error SocialNetwork::Helper::InvalidActorInsertError
      end
      it 'can add actor subclasses, though' do
        expect { subject.push organizational_actor }
          .not_to raise_error
      end
    end
    context '#unshift' do
      it 'adds non duplicate actor to actor list' do
        expect(subject.unshift(actor3, actor4))
          .to eq SocialNetwork::Helper::ActorList.new([actor3, actor4, actor1,
                                                       actor2])
      end
      it 'prevents adding a duplicate actor' do
        expect { subject.unshift(actor1_dup) }
          .to raise_error SocialNetwork::Helper::DuplicateActorError
      end
      it 'prevents insertion of something different than Actor' do
        expect { subject.unshift([actor1, invalid_actor, actor2]) }
          .to raise_error SocialNetwork::Helper::InvalidActorInsertError
      end
      it 'can add actor subclasses, though' do
        expect { subject.unshift organizational_actor }
          .not_to raise_error
      end
    end
  end
  context 'querying objects' do
    subject do
      SocialNetwork::Helper::ActorList
        .new([actor1, personal_actor, organizational_actor])
    end
    it 'returns by id' do
      expect(subject.find_by_id('to1')).to eq organizational_actor
    end
    it 'returns nil if actor is not found' do
      expect(subject.find_by_id('somethingelse')).to be nil
    end
  end
end
