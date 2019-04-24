RSpec.describe 'Integration' do
  it 'works' do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq 'OK'
  end
end
