require 'spec_helper'

RSpec.describe Surveyor::Producer do
  include_context 'a survey'

  let(:responses_data) do
    [
      { email: 'user1@example.org', employee_id: 42, submitted_at: '2014-07-28T20:35:41+00:00', answers: ['5', '5', 'Melbourne'] },
      { email: 'user2@example.org', employee_id: 43, submitted_at: '2014-07-29T20:35:41+00:00', answers: ['4', '4', 'Sydney'] },
      { email: 'user3@example.org', employee_id: 44, submitted_at: nil,                         answers: ['4', '4', 'Sydney'] },
      { email: 'user4@example.org', employee_id: 45, submitted_at: '2014-07-30T20:35:41+00:00', answers: ['4', '1', 'Sydney'] },
      { email: 'user5@example.org', employee_id: 46, submitted_at: '2014-07-31T20:35:41+00:00', answers: ['5', '2', 'Melbourbe'] }
    ]
  end

  subject(:producer) do
    described_class.new(
      survey:         survey,
      responses_data: responses_data
    )
  end

  its(:responses)                 { is_expected.to have(5).items }
  its(:responses_count)           { is_expected.to eq(5) }
  its(:submitted_responses)       { is_expected.to have(4).items }
  its(:submitted_responses_count) { is_expected.to eq(4) }
  its(:aggregated_ratings)        { is_expected.to eq([18, 12]) }
  its(:rating_question_averages)  { is_expected.to eq([4.5, 3]) }

  describe '#aggregated_rating_average' do
    subject { producer.send(:aggregated_rating_average, 0) }

    context 'with participants' do
      it { is_expected.to eq(0) }
    end

    context 'with no participants' do
      let(:responses_data) do
        [
          { email: 'user1@example.org', employee_id: 42, submitted_at: nil, answers: ['5', '5', 'Melbourne'] },
          { email: 'user2@example.org', employee_id: 43, submitted_at: nil, answers: ['4', '4', 'Sydney'] },
          { email: 'user3@example.org', employee_id: 44, submitted_at: nil, answers: ['4', '4', 'Sydney'] },
          { email: 'user4@example.org', employee_id: 45, submitted_at: nil, answers: ['4', '1', 'Sydney'] },
          { email: 'user5@example.org', employee_id: 46, submitted_at: nil, answers: ['5', '2', 'Melbourbe'] }
        ]
      end

      it { is_expected.to eq('N/A') }
    end
  end

  describe '#participation_percentage' do
    its(:participation_percentage) { is_expected.to eq(80) }

    context 'no participants' do
      let(:responses_data) do
        [
          { email: 'user1@example.org', employee_id: 42, submitted_at: nil, answers: ['5', '5', 'Melbourne'] },
          { email: 'user2@example.org', employee_id: 43, submitted_at: nil, answers: ['4', '4', 'Sydney'] },
          { email: 'user3@example.org', employee_id: 44, submitted_at: nil, answers: ['4', '4', 'Sydney'] }
        ]
      end

      its(:participation_percentage) { is_expected.to eq(0) }
    end

    context 'percentage with rounding' do
      let(:responses_data) do
        [
          { email: 'user1@example.org', employee_id: 42, submitted_at: '2014-07-28T20:35:41+00:00', answers: ['5', '5', 'Melbourne'] },
          { email: 'user2@example.org', employee_id: 43, submitted_at: '2014-07-29T20:35:41+00:00', answers: ['4', '4', 'Sydney'] },
          { email: 'user3@example.org', employee_id: 44, submitted_at: nil, answers: ['4', '4', 'Sydney'] }
        ]
      end

      its(:participation_percentage) { is_expected.to eq(66.67) }
    end
  end
end
