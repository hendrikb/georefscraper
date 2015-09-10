require 'spec_helper'
module SocialNetwork
  module Helper
    describe EdgeList do
      let(:node1) { SocialNetwork::Node.new('testid1', 't1', 'l1') }
      let(:node2) { SocialNetwork::Node.new('testid2', 't1', 'l2') }
      let(:node3) { SocialNetwork::Node.new('testid3', 't1', 'l3') }
      let(:node4) { SocialNetwork::Node.new('testid4', 't1', 'l4') }

      let(:edge12) { SocialNetwork::Edge.new(node1, node2, 'te1') }
      let(:edge12_dup) { SocialNetwork::Edge.new(node1, node2, 'te1') }
      let(:edge23) { SocialNetwork::Edge.new(node2, node3, 'te1') }
      let(:edge34) { SocialNetwork::Edge.new(node3, node4, 'te1') }
      let(:invalid_edge) { nil }

      subject { EdgeList.new([edge12, edge34]) }

      it 'adds appropriate number of edges' do
        expect(subject.length).to eq 2
      end

      it 'adds correct edges - and only them' do
        expect(subject).to eq [edge12, edge34]
      end

      it 'prevents insertion of something different than Edges' do
        expect { EdgeList.new([edge12, invalid_edge, edge34]) }
          .to raise_error InvalidEdgeInsertError
      end

      context '#include?' do
        it 'returns true if object with same id is present' do
          expect(subject.include?(edge12_dup)).to be true
        end
        it 'returns false if object with new id is not present' do
          expect(subject.include?(edge23)).to be false
        end
      end
      context 'adding objects' do
        context '#<<' do
          it 'adds non duplicate node to node list' do
            expect(subject << edge23)
              .to eq EdgeList.new([edge12, edge34, edge23])
          end
          it 'prevents adding a duplicate node' do
            expect { subject << edge12_dup }.to raise_error DuplicateEdgeError
          end
          it 'prevents insertion of something different than Edge' do
            expect { subject << invalid_edge }
              .to raise_error InvalidEdgeInsertError
          end
        end
        context '#push' do
          it 'adds non duplicate edge to list' do
            expect(subject.push(edge23))
              .to eq EdgeList.new([edge12, edge34, edge23])
          end
          it 'prevents adding a duplicate edge' do
            expect { subject.push(edge12_dup) }
              .to raise_error DuplicateEdgeError
          end
          it 'prevents insertion of something different than Node' do
            expect { subject.push([edge23, invalid_edge]) }
              .to raise_error InvalidEdgeInsertError
          end
        end
        context '#unshift' do
          it 'adds non duplicate edge to node list' do
            expect(subject.unshift(edge23))
              .to eq EdgeList.new([edge23, edge12, edge34])
          end
          it 'prevents adding a duplicate edge' do
            expect { subject.unshift(edge12_dup) }
              .to raise_error DuplicateEdgeError
          end
          it 'prevents insertion of something different than Edge' do
            expect { subject.unshift([edge23, invalid_edge]) }
              .to raise_error InvalidEdgeInsertError
          end
        end
      end
    end
  end
end
