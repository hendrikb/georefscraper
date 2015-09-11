require 'yaml'
module SocialNetwork
  module Helper
    module ActorLabelSanitizer
      def self.sanitize(label, options = {})
        store = YAML.load_file('config/actor_label_sanitizer.yml')
        replacements = store["replacements"]["en-US"]
        replacements.each do |needle,substitution|
          re = Regexp.new needle
          label.gsub!(re,substitution)
        end
        label
      end
    end
  end
end
