require 'yaml'
module SocialNetwork
  module Helper
    # Provide some drop in logics for {Actor#label} sanitation
    module ActorLabelSanitizer
      # Does some reasonable sanitation according to the
      # config/actor_label_sanitizer.yml file, also removes some trailing and
      # leading whitespace and dashes stuff. See Code for details. This is WIP!
      # @return [String] A sanitized label string
      # @param label [String] An {SocialNetwork::Actor} label to be sanitized
      # @param _options [Hash] An options hash - currently unused
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

      private

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
