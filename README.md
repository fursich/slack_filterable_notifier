# SlackFilterableNotifier
a customizable slack notifier plug-in for exception_notfication

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_filterable_notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_filterable_notifier

## Usage

Specify `slack_filterable` instead of `slack` option for the exception_notfication.

Basically you need to set at least the 'webhook_url' option to configure:

```ruby
Rails.application.config.middleware.use ExceptionNotification::Rack,
  slack_filterable: {
    webhook_url: "[Your webhook url]",
    channel: "#exceptions",
    skip_notifications_with: [ActionController::InvalidAuthenticityToken],
    simplify_notifications_with: [ActiveRecord::RecordInvalid, ActiveRecord::RecordNotUnique],
    color_for_simplified_notifications: :warn,
    :
  }
```

The slack_filterable_notifier uniquely provides the last three options shown above:

- skip_notifications_with
  - exceptions to be skipped with no notifications at all (behaves like 'ignore' option, but **works with only slack notifier**)

- simplify_notifications_with
  - exceptions to be notified with simple format
  - displays Title, Exception, Hostname columns only

- color_for_simplified_notifications
  - pick a color from :good, :warning, :danger, or any hex color code (eg. #439FE0)

Upper-compatible with the original slack notifier with exception_notification gem, meaning ANY options that are accepted by the exception_notfication is available.
(see also [the original repo](https://github.com/smartinez87/exception_notification#slack-notifier) for the details)

## Dependencies

slack_filterable_notifier is build upon the below rubygems (great thanks for the original creators/maintainers), all of which gets installed automatically when you bundle install.

[exception_notification](https://github.com/smartinez87/exception_notification)
[slack-notifier](https://github.com/stevenosloan/slack-notifier)

## Todo

Currently not actively publicized at rubygems as I consider it to be a good potential option to have it merged into the original exception_notification.
This is package as it is for the sake of quick use, but we will see how the PR to the original master goes.
Test are all written in minitests so as to make the merge easier.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fursich/slack_filterable_notifier.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
