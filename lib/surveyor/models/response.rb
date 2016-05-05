module Surveyor
  module Models
    class Response
      attr_reader :survey, :email, :employee_id, :submitted_at, :answers

      def initialize(survey:, email:, employee_id:, submitted_at:, answers:)
        @survey       = survey
        @email        = email
        @employee_id  = employee_id
        @submitted_at = submitted_at
        @answers      = answers
      end

      def submitted?
        !submitted_at.nil?
      end

      def answers_by_type(type)
        answers_with_type.select { |answer| answer[type.to_s] }
                         .map    { |answer| answer[type.to_s] }
      end

      private

      # turn
      #   [5, 5, "Melbourne"]
      # into:
      #   [{ "ratingquestion" => 5 }, { "ratingquestion" => 5 }, { "singleselect" => "Melbourne" }]
      def answers_with_type
        survey.questions.map(&:type).zip(answers).map { |ele| { ele[0] => ele[1] } }
      end
    end
  end
end
