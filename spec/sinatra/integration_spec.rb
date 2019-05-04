# frozen_string_literal: true

RSpec.describe 'Integration' do
  it 'works' do
    get '/', name: 'x'
    expect(last_response).to be_ok
    expect(last_response.body).to eq 'OK'
  end
end
