require 'spec_helper'
module SocialNetwork
  module Helper
    describe ActorList do
      let(:actor1) { SocialNetwork::Actor.new('testid', 't1', 'l1') }
      let(:actor1_dup) { SocialNetwork::Actor.new('testid', 't1', 'l2') }
      let(:actor2) { SocialNetwork::Actor.new('testid2', 't1', 'l3') }
      let(:actor3) { SocialNetwork::Actor.new('testid3', 't1', 'l3') }
      let(:actor4) { SocialNetwork::Actor.new('testid4', 't1', 'l3') }
      let(:invalid_actor) { nil }

      subject { ActorList.new([actor1, actor2]) }

      it 'adds appropriate number of actors' do
        expect(subject.length).to eq 2
      end

      it 'adds correct actors - and only them' do
        expect(subject).to eq [actor1, actor2]
      end

      it 'prevents duplicate actors on initialization' do
        expect { ActorList.new([actor1, actor2, actor1_dup]) }
          .to raise_error DuplicateActorError
      end

      it 'prevents insertion of something different than Actor' do
        expect { ActorList.new([actor1, invalid_actor, actor2]) }
          .to raise_error InvalidActorInsertError
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
              .to eq ActorList.new([actor1, actor2, actor3])
          end
          it 'prevents adding a duplicate actor' do
            expect { subject << actor1_dup }
              .to raise_error DuplicateActorError
          end
          it 'prevents insertion of something different than Actor' do
            expect { subject << invalid_actor }
              .to raise_error InvalidActorInsertError
          end
        end
        context '#push' do
          it 'adds non duplicate actor to actor list' do
            expect(subject.push(actor3, actor4))
              .to eq ActorList.new([actor1, actor2, actor3, actor4])
          end
          it 'prevents adding a duplicate actor' do
            expect { subject.push(actor1_dup) }
              .to raise_error DuplicateActorError
          end
          it 'prevents insertion of something different than Actor' do
            expect { subject.push([actor1, invalid_actor, actor2]) }
              .to raise_error InvalidActorInsertError
          end
        end
        context '#unshift' do
          it 'adds non duplicate actor to actor list' do
            expect(subject.unshift(actor3, actor4))
              .to eq ActorList.new([actor3, actor4, actor1, actor2])
          end
          it 'prevents adding a duplicate actor' do
            expect { subject.unshift(actor1_dup) }
              .to raise_error DuplicateActorError
          end
          it 'prevents insertion of something different than Actor' do
            expect { subject.unshift([actor1, invalid_actor, actor2]) }
              .to raise_error InvalidActorInsertError
          end
        end
      end
    end
  end
end
