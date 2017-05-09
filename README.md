# WebflowData
Short description and motivation.

## Usage
Copy of the initializer
```bash
$ bin/rails generate webflow
# or this does the same thing
$ bundle exec rake webflow_data:copy_initialzer
```

There is a rake task to import all collections and their values
```bash
$ bundle exec rake import_collections
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'webflow_data'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install webflow_data
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
