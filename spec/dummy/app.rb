# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/dry_param'

class App < Sinatra::Base
  register Sinatra::DryParam

  disable :show_exceptions
  enable :raise_errors

  before do
    content_type :json
  end

  params do
    required(:name)
  end

  get '/' do
    validate_params
    'OK'
  end

  params :paging do
    required(:page).filled(:integer, gt?: 0)
    required(:per_page).filled(:integer, gt?: 0)
  end

  get '/page' do
    paging = validate_params :paging
    paging.to_json
  end
end
