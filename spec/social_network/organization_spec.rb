require 'spec_helper'

describe SocialNetwork::Organization do
  it 'is a subclass of Actor' do
    expect(SocialNetwork::Organization.superclass).to be SocialNetwork::Actor
  end
end
