require 'spec_helper'

describe SocialNetwork::Person do
  it 'is a subclass of Actor' do
    expect(SocialNetwork::Person.superclass).to be SocialNetwork::Actor
  end
end
