require 'csv'

module Surveyor
  class Transformer
    attr_reader :survey_file, :responses_file

    def initialize(survey_file:, responses_file:)
      @survey_file    = survey_file
      @responses_file = responses_file
    end

    def transformed_survey_data
      CSV.new(survey_file, headers: true, header_converters: :symbol).to_a.map(&:to_hash)
    end

    def transformed_responses_data
      CSV.new(responses_file).to_a.map do |row|
        {
          email:        row[0],
          employee_id:  row[1],
          submitted_at: row[2],
          answers:      row[3..-1]
        }
      end
    end
  end
end
