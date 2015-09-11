require 'spec_helper'
module SocialNetwork
  module Helper
    describe RelationshipList do
      let(:actor1) { SocialNetwork::Actor.new('testid1', 't1', 'l1') }
      let(:actor2) { SocialNetwork::Actor.new('testid2', 't1', 'l2') }
      let(:actor3) { SocialNetwork::Actor.new('testid3', 't1', 'l3') }
      let(:actor4) { SocialNetwork::Actor.new('testid4', 't1', 'l4') }

      let(:rs12) do
        SocialNetwork::Relationship.new(actor1,
                                        actor2, 'te1')
      end
      let(:rs12_dup) do
        SocialNetwork::Relationship.new(actor1,
                                        actor2, 'te1')
      end
      let(:rs23) do
        SocialNetwork::Relationship.new(actor2,
                                        actor3, 'te1')
      end
      let(:rs34) do
        SocialNetwork::Relationship.new(actor3,
                                        actor4, 'te1')
      end
      let(:invalid_rs) { nil }

      subject { RelationshipList.new([rs12, rs34]) }

      it 'adds appropriate number of relationships' do
        expect(subject.length).to eq 2
      end

      it 'adds correct relationships - and only them' do
        expect(subject).to eq [rs12, rs34]
      end

      it 'prevents insertion of something different than Relationships' do
        expect do
          RelationshipList.new([rs12,
                                invalid_rs, rs34])
        end
          .to raise_error InvalidRelationshipInsertError
      end

      context '#include?' do
        it 'returns true if object with same id is present' do
          expect(subject.include?(rs12_dup)).to be true
        end
        it 'returns false if object with new id is not present' do
          expect(subject.include?(rs23)).to be false
        end
      end
      context 'adding objects' do
        context '#<<' do
          it 'adds non duplicate actor to actor list' do
            expect(subject << rs23)
              .to eq RelationshipList.new([rs12, rs34, rs23])
          end
          it 'prevents adding a duplicate actor' do
            expect { subject << rs12_dup }
              .to raise_error DuplicateRelationshipError
          end
          it 'prevents insertion of something different than Relationship' do
            expect { subject << invalid_rs }
              .to raise_error InvalidRelationshipInsertError
          end
        end
        context '#push' do
          it 'adds non duplicate relationship to list' do
            expect(subject.push(rs23))
              .to eq RelationshipList.new([rs12, rs34, rs23])
          end
          it 'prevents adding a duplicate relationship' do
            expect { subject.push(rs12_dup) }
              .to raise_error DuplicateRelationshipError
          end
          it 'prevents insertion of something different than Actor' do
            expect { subject.push([rs23, invalid_rs]) }
              .to raise_error InvalidRelationshipInsertError
          end
        end
        context '#unshift' do
          it 'adds non duplicate relationship to actor list' do
            expect(subject.unshift(rs23))
              .to eq RelationshipList.new([rs23, rs12, rs34])
          end
          it 'prevents adding a duplicate relationship' do
            expect { subject.unshift(rs12_dup) }
              .to raise_error DuplicateRelationshipError
          end
          it 'prevents insertion of something different than Relationship' do
            expect { subject.unshift([rs23, invalid_rs]) }
              .to raise_error InvalidRelationshipInsertError
          end
        end
      end
    end
  end
end
