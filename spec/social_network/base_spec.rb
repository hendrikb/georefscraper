require 'spec_helper'

module SocialNetwork
  describe Base do
    context '.initialize' do
      subject { SocialNetwork::Base.new('testing') }
      it 'creates an SocialNetwork::Base' do
        expect(subject).to be_kind_of SocialNetwork::Base
      end

      it 'enforces name for the social network' do
        expect { SocialNetwork::Base.new(nil) }.to raise_error NameMissingError
      end

      it 'creates object with a name' do
        expect(subject.name).to eql('testing')
      end

      context 'Node handling' do
        it 'creates object with an nodes array' do
          expect(subject.nodes).to be_kind_of SocialNetwork::Helper::NodeList
        end

        it 'has frozen nodes' do
          expect(subject.nodes).to be_frozen
        end

        it 'it raises nicely when trying to modify a frozen NodeList' do
          exc_msg  = "can't modify frozen SocialNetwork::Helper::NodeList"
          expect { subject.nodes << (Node.new('x', 'y', 'z')) }
            .to raise_error(RuntimeError,
                            exc_msg)
        end

        it 'enables to push single nodes' do
          n1 = Node.new('n1', 't1', 'l1')
          expect { subject.push_node(n1) }
            .to change { subject.nodes.length }.by 1
        end

        it 'raises if trying to push duplicate nodes' do
          n1 = Node.new('n1', 't1', 'l1')
          n1_dup = Node.new('n1', 't1', 'l1')
          subject.push_node(n1)
          expect { subject.push_node(n1_dup) }
            .to raise_error Helper::DuplicateNodeError
        end
      end

      context 'edge handling' do
        it 'creates object with an edges array' do
          expect(subject.edges).to be_kind_of SocialNetwork::Helper::EdgeList
        end

        it 'has frozen edges' do
          expect(subject.edges).to be_frozen
        end

        it 'it raises nicely when trying to modify a frozen EdgeList' do
          exc_msg = "can't modify frozen SocialNetwork::Helper::EdgeList"
          n1 = Node.new('n1', 't1', 'l1')
          n2 = Node.new('n2', 't2', 'l2')
          expect { subject.edges << (Edge.new(n1, n2, 't1')) }
            .to raise_error(RuntimeError,
                            exc_msg)
        end

        it 'enables to push single edge' do
          n1 = Node.new('n1', 't1', 'l1')
          n2 = Node.new('n1', 't1', 'l1')
          expect { subject.push_edge(Edge.new(n1, n2, 't1')) }
            .to change { subject.edges.length }.by 1
        end

        it 'raises if trying to push duplicate nodes' do
          pending
          n1 = Node.new('n1', 't1', 'l1')
          n2 = Node.new('n2', 't1', 'l2')
          subject.push_node(n1)
          subject.push_node(n2)
          subject.push_edge(Edge.new(n1, n2, 't1'))
          edge1_dup = Edge.new(n1, n2, 't1')
          expect { subject.push_edge(edge1_dup) }
            .to raise_error Helper::DuplicateEdgeError
        end
      end
    end
  end
end
