# Checks

Checks is a simple API wrapper for health check services, Ala [healthchecks.io](https://healthchecks.io) and Dead Man's Snitch.

Currently we only support [healthchecks.io](https://healthchecks.io), but we're open to any service you can wish to use.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'checks'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install checks

## Usage

Designed for use within Rails, to use, add a file in `config/checks.yml` with roughly the following format:

```YAML
---
group:
  key_a: "uuid-goes-here"
other:
  key_b: "uuid-goes-here"
```

Where `group` and `other` are groups, and each pair underneath is a key combined with a [healthchecks.io](https://healthchecks.io) UUID. It's designed
to be the id-relevant to the specific healthcehck service.

Then, in your code, to trigger a checkin:

```ruby
Checks.checkin :other, :key_b
```

This version will fail silently with an unknown group or key. If you want to to fail with an exception,
instead use:

```ruby
Checks.checkin! :other, :key_b
```

Finally, to invoke a manual specific id (e.g. from code):

```ruby
Checkins.manual_checkin "my-uuid-here"
```

Note that currently it is tied to [healthchecks.io](https://healthchecks.io), but the plan is to add support for other services longer term.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gyde-tv/checks. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
