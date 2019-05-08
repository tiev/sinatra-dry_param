# frozen_string_literal: true

RSpec.describe 'Pre-defined Schema' do
  class PredefinedSchemaApp < App
    ParamSchema = Dry::Schema.Params do
      required(:page).filled(:integer)
      required(:per_page).filled(:integer)
    end

    params :predefined, schema: ParamSchema

    get '/predefined' do
      paging = validate_params :predefined
      paging.to_json
    end
  end

  def app
    PredefinedSchemaApp
  end

  it 'works' do
    get '/predefined', page: 1, per_page: 10
    expect(last_response).to be_ok
    expect(last_response.body).to eq({ page: 1, per_page: 10 }.to_json)
  end
end
