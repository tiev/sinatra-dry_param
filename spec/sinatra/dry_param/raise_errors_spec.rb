# frozen_string_literal: true

RSpec.describe 'Raise Errors' do
  class ExcApp < App
    enable :raise_dry_param_exceptions
  end

  def app
    ExcApp
  end

  it 'raises errors' do
    expect { get '/' }.to raise_error(Sinatra::DryParam::InvalidParamsError, '{:name=>["is missing"]}')

    begin
      get '/'
    rescue Sinatra::DryParam::InvalidParamsError => e
      expect(e.results).to be_an_instance_of(Dry::Schema::MessageSet)
    end
  end
end
