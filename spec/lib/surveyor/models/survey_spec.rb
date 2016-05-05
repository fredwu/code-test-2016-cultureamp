require 'spec_helper'

RSpec.describe Surveyor::Models::Survey do
  let(:survey_questions) do
    [
      { theme: 'The Work',     type: 'ratingquestion', text: 'I like the kind of work I do.' },
      { theme: 'The Work',     type: 'ratingquestion', text: 'I am appropriately involved in decisions that affect my work.' },
      { theme: 'Demographics', type: 'singleselect',   text: 'City' }
    ]
  end

  subject(:survey) { described_class.new(survey_questions) }

  describe '#questions' do
    subject { survey.questions }

    its(:length) { is_expected.to eq(3) }
    its(:first)  { is_expected.to be_kind_of(Surveyor::Models::SurveyQuestion) }
  end

  describe 'a question' do
    subject { survey.questions.first }

    its(:theme) { is_expected.to eq('The Work') }
    its(:type)  { is_expected.to eq('ratingquestion') }
    its(:text)  { is_expected.to eq('I like the kind of work I do.') }
  end
end
