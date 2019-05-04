# frozen_string_literal: true

RSpec.describe 'Named Params' do
  it 'returns validated params' do
    get '/page', page: 1, per_page: 10
    expect(last_response).to be_ok
    expect(last_response.body).to eq({ page: 1, per_page: 10 }.to_json)
  end

  it 'halts with status 400 for invalid params' do
    get '/page', page: 0
    expect(last_response).to be_bad_request
    errors = { "page": ['must be greater than 0'], "per_page": ['is missing'] }
    expect(last_response.body).to eq(errors.to_json)
  end
end
