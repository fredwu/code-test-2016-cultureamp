module Surveyor
  class Producer
    attr_reader :survey, :responses_data

    def initialize(survey:, responses_data:)
      @survey         = survey
      @responses_data = responses_data
    end

    def participation_percentage
      (submitted_responses_count.to_f / responses_count * 100).round(2)
    end

    def rating_question_averages
      aggregated_ratings.map do |aggregated_rating|
        aggregated_rating_average(aggregated_rating)
      end
    end

    def submitted_responses_count
      submitted_responses.length
    end

    private

    def responses
      @responses ||= responses_data.map do |response_data|
        Models::Response.new(survey: survey, **response_data)
      end
    end

    def responses_count
      responses.length
    end

    def submitted_responses
      responses.select(&:submitted?)
    end

    def aggregated_rating_average(aggregated_rating)
      average = (aggregated_rating.to_f / submitted_responses_count).round(2)

      average.nan? ? 'N/A' : average
    end

    def aggregated_ratings
      submitted_responses.inject(Array.new(num_of_rating_questions, 0)) do |aggregated, response|
        aggregated.zip(response.answers_by_type(:ratingquestion)).map { |ratings| ratings.map(&:to_i).inject(&:+) }
      end
    end

    def num_of_rating_questions
      survey.questions_by_type(:ratingquestion).length
    end
  end
end
