require_relative './lib/social_network'
require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

namespace :lombardi_graphml do
  desc 'Import social network lombardi graphml [proof, not working]'
  task :import, [:graphml, :name] do |_t, args|
    SocialNetwork::Parser::GraphML.parse(File.new(args[:graphml]), args[:name])
  end
  namespace :convert_to do
    desc 'Convert lombardi GraphML representation to DOT graph file format'
    task :dot, [:graphml, :name] do |_t, args|
      social_network = SocialNetwork::Parser::GraphML.parse(
        File.new(args[:graphml]), args[:name])

      SocialNetwork::Converter::DOT::Parser.new(social_network,
                                                overwrite_name: args[:name])
    end
  end
end

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new do |t|
  t.name    = 'doc:create'
  t.files   = ['lib/**/*.rb']
  t.stats_options = ['--list-undoc']
  t.after = proc do
    puts "\nIf you see undocumented parts of code, feel free to help out. :)"
  end
end

RuboCop::RakeTask.new
