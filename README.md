# Sinatra::DryParam

This sinatra extension provides easy interfaces for validating params. It serves both schema validation and strong-params feature.

Validation is processed by [dry-schema](https://github.com/dry-rb/dry-schema), provides robust type and schema validation.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sinatra-dry_param'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-dry_param

## Usage

Register and use the extension in your sinatra app, for classic style sinatra app:


```ruby
require 'sinatra'
require 'sinatra/dry_param'

params do
  required(:name).filled(:string)
end

get '/hello' do
  data = validate_params
  h "Hello #{data[:name]}!"
end
```

Or for modular style sinatra app:

```ruby
require 'sinatra/base'
require 'sinatra/dry_param'

class App < Sinatra::Base
  register Sinatra::DryParam

  params do
    required(:name).filled(:string)
  end

  get '/hello' do
    data = validate_params
    h "Hello #{data[:name]}!"
  end
end
```

### Define params schemas

One or more schemas can be defined using method `::params`, distinguised by names:

```ruby
class App < Sinatra::Base
  register Sinatra::DryParam

  params do
    # dry-schema definitions
  end

  params :paging do
    # different name as :paging
  end

  params do
    # Override the previous schema in whole class scope.
    # Should only override parent class' schemas.
  end

  get '/' do
    validate_params                          # Use the default schema to validate params
    validate_params :dry, params             # Same with above line, the default schema name is :dry
    validate_params :paging, params[:paging] # Use the :paging schema to validate one param
  end
```

### Schema definition

The block passed in `::params` is the block passed to `Dry::Schema.Params` of dry-schema.

For syntax of schema definition, please refer to dry-schema [documentation](https://dry-rb.org/gems/dry-schema/).

### Reusing param schemas

Defined params can be retrieved as app settings, using the schema name with `"_params"` suffix.

```ruby
  settings.dry_params
  settings.paging_params
```

And we can reuse schemas as how dry-schema is [reused](https://dry-rb.org/gems/dry-schema/reusing-schemas/)

```ruby
  params :address do
    required(:city).filled(:string)
    required(:street).filled(:string)
    required(:zipcode).filled(:string)
  end

  params do
    required(:email).filled(:string)
    required(:name).filled(:string)
    required(:address).hash(settings.address_params)
  end

  post '/users' do
    input = validate_params
    User.create_with_address(input)
  end
```

### Render response

By default, if `validate_params` failed, the action is halted with status 400 and render errors.

```ruby
params do
  required(:page).filled(:integer, gt?: 0)
  required(:per_page).filled(:integer, gt?: 0)
end

get '/' do
  validate_params
end

#client
get '/', page: 0
#> Response body: { "page": ['must be greater than 0'], "per_page": ['is missing'] }
```

You can customize the behavior with this enable setting `raise_dry_param_exceptions` and catch the exception:

```ruby
class App < Sinatra::Base
  register Sinatra::DryParam

  enable :raise_dry_param_exceptions

  error Sinatra::DryParam::InvalidParamsError do
    "Your params is not valid: " + env['sinatra.error'].results.to_h.to_s
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tiev/sinatra-dry_param. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sinatra::DryParam project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/tiev/sinatra-dry_param/blob/master/CODE_OF_CONDUCT.md).
