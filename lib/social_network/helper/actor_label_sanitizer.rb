require 'yaml'
module SocialNetwork
  module Helper
    module ActorLabelSanitizer
      def self.sanitize(label, _options = {})
        label = clean_from_dashes(label)
        store = YAML.load_file('config/actor_label_sanitizer.yml')
        replacements = store['replacements']['en-US']
        replacements.each do |needle, substitution|
          re = Regexp.new needle
          label.gsub!(re, substitution)
        end
        label
      end

      def self.clean_from_dashes(label)
        label.gsub!(/ \-$/, '')
        label.gsub!(' - ', ' ')
        label.strip!
        label.sub!(/\-\z/, '') if label.match(/[a-z]+\-\z/)
        label
      end
    end
  end
end
