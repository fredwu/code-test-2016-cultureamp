module Surveyor
  class Presenter
    attr_reader :producer

    def initialize(producer)
      @producer = producer
    end

    def present
      <<-STRING
  * Participation percentage: #{producer.participation_percentage}%
  * Total participant counts: #{producer.submitted_responses_count}

  Rating questions:
#{rating_questions_print}
      STRING
    end

    private

    def rating_questions_print
      prints = []

      producer.survey.questions_by_type(:ratingquestion).each_with_index do |question, index|
        prints << "  * Average Rating: #{producer.rating_question_averages[index]} | Question: #{question.text}"
      end

      prints.join("\n")
    end
  end
end
