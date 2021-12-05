RSpec.shared_context 'prepare_test', :shared_context => :metadata do
  def prepare(access_token)
    @access_token = access_token

    # preview_info
    path = '/api/v1/tests/preview_info'
    get path,
        headers: { 'Access-Token': @access_token },
        params: {
          test_t_id: test_template.id
        }

    expect(response.status).to eq 200
    expect(Test.count).to eq 1
    expect(QuestionTemplate.count).to eq 1
    expect(Question.count).to eq 1

    # question first
    path = '/api/v1/questions/get'
    @test = Test.find(json_result['test_id'])

    get path,
        headers: { 'Access-Token': @access_token },
        params: {
          test_id: @test.id,
          question_number: 1,
        }

    json_result = JSON.parse(response.body)

    expect(response.status).to eq 200
    expect(json_result['question']['number']).to eq 1
  end

  def set_answers(answers, type)
    path = '/api/v1/questions/set_answers'
    patch path,
          headers: { 'Access-Token': @access_token },
          params: {
            answers: answers,
            test_id: @test.id,
            question_number: 1,
            question_type: type,
          }

    expect(response.status).to eq 200
  end

  def get_result(desired_result)
    # need for starting job
    Sidekiq::Testing.inline!

    path = '/api/v1/tests/results'
    get path,
        headers: { 'Access-Token': @access_token },
        params: { test_id: @test.id }

    expect(response.status).to eq 200
    expect(@test.result.value).to eq desired_result
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'prepare_test', include_shared: true
end