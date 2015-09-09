require 'spec_helper'
module SocialNetwork
  module Helper
    describe NodeList do
      let(:node1) { SocialNetwork::Node.new('testid', 't1', 'l1') }
      let(:node1_dup) { SocialNetwork::Node.new('testid', 't1', 'l2') }
      let(:node2) { SocialNetwork::Node.new('testid2', 't1', 'l3') }
      let(:node3) { SocialNetwork::Node.new('testid3', 't1', 'l3') }
      let(:node4) { SocialNetwork::Node.new('testid4', 't1', 'l3') }

      subject { NodeList.new([node1, node2]) }

      it 'adds appropriate number of nodes' do
        expect(subject.length).to eq 2
      end

      it 'adds appropriate number of nodes' do
        expect(subject).to eq [node1, node2]
      end

      it 'prevents duplicate nodes on initialization' do
        expect { NodeList.new([node1, node2, node1_dup]) }
          .to raise_error DuplicateNodeError
      end

      context '#include?' do
        it 'returns true if object with same id is present' do
          expect(subject.include?(node1_dup)).to be true
        end
        it 'returns false if object with new id is not present' do
          expect(subject.include?(node3)).to be false
        end
      end

      context 'adding objects' do
        context '#<<' do
          it 'adds non duplicate node to node list' do
            expect(subject << node3).to eq NodeList.new([node1, node2, node3])
          end
          it 'prevents adding a duplicate node' do
            expect { subject << node1_dup }.to raise_error DuplicateNodeError
          end
        end
        context '#push' do
          it 'adds non duplicate node to node list' do
            expect(subject.push(node3, node4)).to eq NodeList.new([node1, node2, node3, node4])
          end
          it 'prevents adding a duplicate node' do
            expect { subject.push(node1_dup) }.to raise_error DuplicateNodeError
          end
        end
        context '#unshift' do
          it 'adds non duplicate node to node list' do
            expect(subject.unshift(node3, node4)).to eq NodeList.new([node3, node4, node1, node2])
          end
          it 'prevents adding a duplicate node' do
            expect { subject.unshift(node1_dup) }.to raise_error DuplicateNodeError
          end
        end
      end
    end
  end
end
