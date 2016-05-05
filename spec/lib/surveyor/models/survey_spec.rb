require 'spec_helper'

RSpec.describe Surveyor::Models::Survey do
  include_context 'a survey'

  describe '#questions' do
    subject(:questions) { survey.questions }

    its(:length) { is_expected.to eq(3) }
    its(:first)  { is_expected.to be_kind_of(Surveyor::Models::SurveyQuestion) }

    describe 'a question' do
      subject { questions.first }

      its(:theme) { is_expected.to eq('The Work') }
      its(:type)  { is_expected.to eq('ratingquestion') }
      its(:text)  { is_expected.to eq('I like the kind of work I do.') }
    end
  end

  describe '#questions_by_type' do
    subject(:rating_questions) { survey.questions_by_type(:ratingquestion) }

    its(:length) { is_expected.to eq(2) }

    describe 'rating question' do
      subject { rating_questions.last }

      its(:type) { is_expected.to eq('ratingquestion') }
    end
  end
end
