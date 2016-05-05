module Surveyor
  module Models
    class SurveyQuestion
      attr_reader :theme, :type, :text

      def initialize(theme:, type:, text:)
        @theme = theme
        @type  = type
        @text  = text
      end
    end
  end
end
