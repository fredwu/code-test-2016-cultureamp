module Surveyor
  class Workflow
    def self.run(survey_file_path:, responses_file_path:)
      transformer = Transformer.new(
        survey_file:    File.new(survey_file_path),
        responses_file: File.new(responses_file_path)
      )

      producer = Producer.new(
        survey:         Models::Survey.new(questions_data: transformer.transformed_survey_data),
        responses_data: transformer.transformed_responses_data
      )

      print Presenter.new(producer).present
    end
  end
end
