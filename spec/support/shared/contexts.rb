RSpec.shared_context 'a survey' do
  let(:questions_data) do
    [
      { theme: 'The Work',     type: 'ratingquestion', text: 'I like the kind of work I do.' },
      { theme: 'The Work',     type: 'ratingquestion', text: 'I am appropriately involved in decisions that affect my work.' },
      { theme: 'Demographics', type: 'singleselect',   text: 'City' }
    ]
  end

  subject(:survey) do
    Surveyor::Models::Survey.new(questions_data: questions_data)
  end
end
