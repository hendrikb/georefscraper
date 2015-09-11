require 'spec_helper'

module SocialNetwork
  describe Base do
    context '.initialize' do
      subject { SocialNetwork::Base.new('testing') }
      it 'creates a SocialNetwork::Base' do
        expect(subject).to be_kind_of SocialNetwork::Base
      end

      it 'takes options' do
        subject = SocialNetwork::Base.new('testing', [], [], test_option: true)
        expect(subject.options[:test_option]).to be true
      end

      it 'enforces name for the social network' do
        expect { SocialNetwork::Base.new(nil) }.to raise_error NameMissingError
      end

      it 'creates object with a name' do
        expect(subject.name).to eql('testing')
      end

      context 'Actor handling' do
        it 'creates object with an actors array' do
          expect(subject.actors).to be_kind_of SocialNetwork::Helper::ActorList
        end

        it 'has frozen actors' do
          expect(subject.actors).to be_frozen
        end

        it 'it raises nicely when trying to modify a frozen ActorList' do
          exc_msg  = "can't modify frozen SocialNetwork::Helper::ActorList"
          expect { subject.actors << (Actor.new('x', 'y', 'z')) }
            .to raise_error(RuntimeError,
                            exc_msg)
        end

        it 'enables to push single actors' do
          n1 = Actor.new('n1', 't1', 'l1')
          expect { subject.push_actor(n1) }
            .to change { subject.actors.length }.by 1
        end

        it 'raises if trying to push duplicate actors' do
          n1 = Actor.new('n1', 't1', 'l1')
          n1_dup = Actor.new('n1', 't1', 'l1')
          subject.push_actor(n1)
          expect { subject.push_actor(n1_dup) }
            .to raise_error Helper::DuplicateActorError
        end
      end

      context 'relationship handling' do
        it 'creates object with an relationships array' do
          expect(subject.relationships)
            .to be_kind_of SocialNetwork::Helper::RelationshipList
        end

        it 'has frozen relationships' do
          expect(subject.relationships).to be_frozen
        end

        it 'it raises nicely when trying to modify a frozen RelationshipList' do
          msg = "can't modify frozen SocialNetwork::Helper::RelationshipList"
          n1 = Actor.new('n1', 't1', 'l1')
          n2 = Actor.new('n2', 't2', 'l2')
          expect { subject.relationships << (Relationship.new(n1, n2, 't1')) }
            .to raise_error(RuntimeError,
                            msg)
        end

        it 'enables to push single relationship' do
          n1 = Actor.new('n1', 't1', 'l1')
          n2 = Actor.new('n1', 't1', 'l1')
          expect { subject.push_relationship(Relationship.new(n1, n2, 't1')) }
            .to change { subject.relationships.length }.by 1
        end

        it 'raises if trying to push duplicate actors' do
          n1 = Actor.new('n1', 't1', 'l1')
          n2 = Actor.new('n2', 't1', 'l2')
          subject.push_actor(n1)
          subject.push_actor(n2)
          subject.push_relationship(Relationship.new(n1, n2, 't1'))
          relationship1_dup = Relationship.new(n1, n2, 't1')
          expect { subject.push_relationship(relationship1_dup) }
            .to raise_error Helper::DuplicateRelationshipError
        end
      end
    end
  end
end
