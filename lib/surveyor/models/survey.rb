require 'surveyor/models/survey_question'

module Surveyor
  module Models
    class Survey
      attr_reader :questions_data

      def initialize(questions_data:)
        @questions_data = questions_data
      end

      def questions
        questions_data.map do |survey_question|
          SurveyQuestion.new(**survey_question)
        end
      end
    end
  end
end
