# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/dry_param/version'
require 'dry/initializer'

module Sinatra
  module DryParam
    class InvalidParamsError < StandardError
      extend Dry::Initializer
      param :results
    end

    module Helpers
      def validate_params(name = :dry, prs = params)
        result = settings.send("#{name}_params").call(prs)
        if result.success?
          result.to_h
        else
          raise InvalidParamsError.new(results: result.errors) if settings.raise_dry_param_exceptions?

          halt 400, result.errors.to_h.to_json
        end
      end
    end

    def params(name = :dry, &block)
      set "#{name}_params", Dry::Schema.Params(&block)
    end

    def self.registered(app)
      require 'dry/schema'
      app.helpers DryParam::Helpers

      app.disable :raise_dry_param_exceptions
    end
  end

  register DryParam
end
