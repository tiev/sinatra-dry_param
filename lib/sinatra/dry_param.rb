# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/dry_param/version'

module Sinatra
  module DryParam
    class InvalidParamsError < StandardError
      attr_reader :results

      def initialize(msg, results)
        @results = results
        super(msg)
      end
    end

    module Helpers
      def validate_params(name = :dry, prs = params)
        result = settings.send("#{name}_param_schema").call(prs)
        if result.success?
          result.to_h
        else
          raise InvalidParamsError.new(result.errors.to_h.to_s, result.errors) if settings.raise_dry_param_exceptions?

          halt 400, result.errors.to_h.to_json
        end
      end
    end

    def params(name = :dry, schema: nil, &block)
      schema ||= Dry::Schema.Params(&block)
      set "#{name}_param_schema", schema
    end

    def self.registered(app)
      require 'dry/schema'
      app.helpers DryParam::Helpers

      app.disable :raise_dry_param_exceptions
    end
  end

  register DryParam
end
