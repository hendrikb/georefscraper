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
      sn = SocialNetwork::Parser::GraphML.parse(
        File.new(args[:graphml]), args[:name])

      puts "graph #{sn.id} {"
      sn.nodes.each do |node|
        puts "n#{node.id} [label=\"#{node.label.delete('"')}\"];"
      end
      sn.edges.each do |edge|
        puts "n#{edge.source.id} -- n#{edge.target.id};"
      end
      puts '}  // drop this code into a graphviz tool, like so:'
      puts '   //   dot -Tpng -ograph.png test.dot'
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
