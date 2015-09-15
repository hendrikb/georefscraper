require_relative './lib/social_network'

require 'yard'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

namespace :lombardi_graphml do
  namespace :merge_to do
    desc "Merge graphml files (space sep't) by their actor labels to dot graph"
    task :dot, [:graphmls] do |_t, args|
      require 'digest'

      result_actors = SocialNetwork::Helper::ActorList.new([])
      result_relationships = SocialNetwork::Helper::RelationshipList.new([])
      args[:graphmls].split(' ').each do |graphml|
        sn = SocialNetwork::Parser::GraphML.parse(File.new(graphml))
        sn.actors.each do |actor|
          actor.id = Digest::SHA256.base64digest(actor.label)
          begin
            result_actors << actor
          rescue SocialNetwork::Helper::DuplicateActorError
            $stderr.puts "// #{graphml}: duplicate actor #{actor}"
          end
        end

        sn.relationships.each do |rl|
          begin
            result_relationships << rl
          rescue SocialNetwork::Helper::DuplicateRelationshipError
            $stderr.puts "// #{graphml}: duplicate relationship #{rl}"
          end
        end
      end
      results = SocialNetwork::Base.new('Results', result_actors,
                                        result_relationships)
      puts SocialNetwork::Converter::Dot.convert(results)
    end
  end

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

    desc 'Print out all Actors from GraphML file'
    task :actor_list, [:graphml] do |_t, args|
      social_network = SocialNetwork::Parser::GraphML.parse(
        File.new(args[:graphml]), ommit_relationships: true)
      puts SocialNetwork::Converter::ActorList.convert(social_network)
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
