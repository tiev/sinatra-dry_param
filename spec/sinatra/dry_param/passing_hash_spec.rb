# frozen_string_literal: true

RSpec.describe 'Passing Hash' do
  it 'works' do
    post '/part', user: { name: 'viet', age: 20 }
    expect(last_response).to be_ok
    expect(last_response.body).to eq({ name: 'viet', age: 20 }.to_json)
  end
end
