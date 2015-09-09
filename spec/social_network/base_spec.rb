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

      it 'creates object with an nodes array' do
        expect(subject.nodes).to be_kind_of SocialNetwork::Helper::NodeList
      end

      it 'creates object with an edges array' do
        expect(subject.edges).to be_kind_of SocialNetwork::Helper::EdgeList
      end
    end
  end
end
