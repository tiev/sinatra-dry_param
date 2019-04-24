require 'sinatra/base'
require 'sinatra/dry_param'

class App < Sinatra::Base
  disable :show_exceptions
  enable :raise_errors

  register Sinatra::DryParam

  before do
    content_type :json
  end

  get '/' do
    validate_params
    'OK'
  end
end
