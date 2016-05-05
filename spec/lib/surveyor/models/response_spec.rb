require 'spec_helper'

RSpec.describe Surveyor::Models::Response do
  include_context 'a survey'

  let(:default_response_data) do
    {
      email:        'user@example.org',
      employee_id:  42,
      submitted_at: '2014-07-28T20:35:41+00:00',
      answers:      ['5', '5', 'Melbourne']
    }
  end

  let(:response_data) { default_response_data }

  subject(:response) { described_class.new(survey: survey, **response_data) }

  its(:survey)       { is_expected.to eq(survey) }
  its(:email)        { is_expected.to eq('user@example.org') }
  its(:employee_id)  { is_expected.to eq(42) }
  its(:submitted_at) { is_expected.to eq('2014-07-28T20:35:41+00:00') }
  its(:answers)      { is_expected.to eq(['5', '5', 'Melbourne']) }

  describe '#submitted?' do
    context 'yes' do
      it { is_expected.to be_submitted }
    end

    context 'no' do
      let(:response_data) { default_response_data.merge(submitted_at: nil) }

      it { is_expected.not_to be_submitted }
    end
  end

  describe '#answers_by_type' do
    subject { response.answers_by_type(:ratingquestion) }

    it { is_expected.to eq(['5', '5']) }
  end

  its(:answers_with_type) { is_expected.to eq([{ 'ratingquestion' => '5' }, { 'ratingquestion' => '5' }, { 'singleselect' => 'Melbourne' }]) }
end
