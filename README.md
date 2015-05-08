[![Dependency Status](https://gemnasium.com/rikas/slack-poster.svg)](https://gemnasium.com/rikas/slack-poster)

# Slack Poster

slack-poster is a simple gem to make your integration with Slack easier. It supports only incoming
communications (from you to Slack).

## Installation

Add this line to your application's Gemfile:

```console
$ gem 'slack-poster'
```

And then execute:

```console
$ bundle
```

Or install it yourself as:

```console
$ gem install slack-poster
```

## Slack setup

This gem will use a Incoming WebHook integration on Slack. First, you need to create a new
Incoming Webhook integration at `https://team-name.slack.com/services/new/incoming-webhook` (where
"team-name" should be your own team name).

![](http://cl.ly/image/2D2Y0x2B2847/slack_setup1.png)

Hit "Add Incoming WebHooks Integration" and go to the next screen. Here you can add a name to your
integration, customize the username that will post and the icon.

![](http://cl.ly/image/2s3r343K0w3T/slack_setup2.png)

Copy the Webhook URL, because you'll need it. Click "Save Settings" and you're done.

## Usage

First you have to initialize your poster and then you can use `send_message` to send your message.

```ruby
poster = Slack::Poster.new(YOUR_WEBHOOK_URL)
poster.send_message('Hello world!')
```

You can use an options array if you don't want to use the default settings:

```ruby
options = {
  icon_url: 'http://example.com/image.png',
  # or icon_emoji: 'emoji_name',
  username: 'Tester',
  channel: '#random'
}
```

And then use it as a second parameter. Note that every option is optional (no pun intended!).

```ruby
poster = Slack::Poster.new(YOUR_WEBHOOK_URL, options)
poster.send_message('Hello with options') # will send to #random with the username 'Tester'
```

## Message attachments

COMING SOON!

## Contributing

1. Fork it ( http://github.com/rikas/slack-poster/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
