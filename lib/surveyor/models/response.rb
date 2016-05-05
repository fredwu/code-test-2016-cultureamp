require 'surveyor/models/survey'

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
    end
  end
end
