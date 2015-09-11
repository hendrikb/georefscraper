require 'spec_helper'

describe SocialNetwork::Converter::Dot do
  let(:me) { SocialNetwork::Node.new('n1', 'tP', 'Hendrik') }
  let(:mum) { SocialNetwork::Node.new('n2', 'tP', 'Mum') }
  let(:dad) { SocialNetwork::Node.new('n3', 'tP', 'Dad') }

  let(:relationship_married) do
    SocialNetwork::Relationship.new(mum, dad,
                                    'married')
  end
  let(:relationship_f_son) { SocialNetwork::Relationship.new(dad, me, 'son') }
  let(:relationship_m_son) { SocialNetwork::Relationship.new(mum, me, 'son') }

  let(:network) do
    node_list = SocialNetwork::Helper::NodeList.new([me, mum, dad])
    relationship_list = SocialNetwork::Helper::RelationshipList.new(
      [relationship_married, relationship_f_son, relationship_m_son])

    SocialNetwork::Base.new('The "Test" Family', node_list, relationship_list)
  end

  context 'conversion' do
    it 'responds to module method convert' do
      expect(SocialNetwork::Converter::Dot).to respond_to(:convert)
        .with(2).arguments
    end
    it 'converts stuff to dot' do
      ref_dot_code = <<EOF
graph \"The Test Family\" {
\t"n1" [label="Hendrik"];
\t"n2" [label="Mum"];
\t"n3" [label="Dad"];
\t"n2" -- "n3";
\t"n3" -- "n1";
\t"n2" -- "n1";
}  // drop this code into a graphviz tool, like so:
   //   dot -Tpng -ograph.png test.dot
EOF
      expect(SocialNetwork::Converter::Dot.convert(network)).to eq ref_dot_code
    end
  end
end
