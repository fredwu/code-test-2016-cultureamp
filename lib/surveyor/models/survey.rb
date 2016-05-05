require 'surveyor/models/survey_question'

module Surveyor
  module Models
    class Survey
      attr_reader :survey_questions

      def initialize(survey_questions)
        @survey_questions = survey_questions
      end

      def questions
        survey_questions.map do |survey_question|
          SurveyQuestion.new(**survey_question)
        end
      end
    end
  end
end
