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
    # Intentional blank
  end

  get '/' do
    validate_params
    'OK'
  end
end
