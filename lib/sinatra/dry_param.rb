# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/dry_param/version'

module Sinatra
  module DryParam
    class Error < StandardError; end

    module Helpers
      def validate_params
        schema = Dry::Schema.Params
        schema.call(params)
      end
    end

    def self.registered(app)
      require 'dry/schema'

      app.helpers DryParam::Helpers
    end
  end

  register DryParam
end
