require 'spec_helper'

module SocialNetwork
  module Helper
    describe ActorLabelSanitizer do
      it { should respond_to(:sanitize).with(1).arguments }
      it { should respond_to(:sanitize).with(2).arguments }

      context 'substitutions' do
        it 'replaces based on a string that was given somewhere' do
          expect(ActorLabelSanitizer.sanitize('Test U.K. Bla'))
            .to eq 'Test United Kingdom Bla'
        end

        it 'does multiple replaces' do
          expect(ActorLabelSanitizer.sanitize('The U.K. Gvmt.'))
            .to eq 'The United Kingdom Government'
        end
      end
    end
  end
end
