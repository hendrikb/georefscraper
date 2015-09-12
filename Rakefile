require_relative './lib/social_network'

require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

namespace :lombardi_graphml do
  desc 'Validate social network lombardi graphml. Look for exceptions in files!'
  task :validate, [:graphml, :name] do |_t, args|
    begin
      print "Validating #{args[:graphml]} ... "
      SocialNetwork::Parser::GraphML.parse(File.new(args[:graphml]))
    rescue StandardError => e
      $stderr.puts "\nThe graphml #{args[:graphml]} couldn't be validated"
      $stderr.puts "The error while building up the structure was:\n\t#{e}"
      exit 1
    end
    puts 'OK'
  end
  namespace :convert_to do
    desc 'Convert lombardi GraphML representation to DOT graph file format'
    task :dot, [:graphml, :name] do |_t, args|
      social_network = SocialNetwork::Parser::GraphML.parse(
        File.new(args[:graphml]), network_name: args[:name])

      puts SocialNetwork::Converter::Dot.convert(social_network)
    end

    desc 'Print out all Nodes from GraphML file'
    task :node_list, [:graphml] do |_t, args|
      social_network = SocialNetwork::Parser::GraphML.parse(
        File.new(args[:graphml]), ommit_relationships: true)
      puts SocialNetwork::Converter::NodeList.convert(social_network)
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
