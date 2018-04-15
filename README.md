[![Dependency Status](https://gemnasium.com/rikas/slack-poster.svg)](https://gemnasium.com/rikas/slack-poster)
[![Build Status](https://travis-ci.org/rikas/slack-poster.svg?branch=master)](https://travis-ci.org/rikas/slack-poster)

# Slack Poster

slack-poster is a simple gem to make your integration with Slack easier. It supports only incoming communications (from you to Slack).

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

This gem will use a Incoming WebHook integration on Slack. First, you need to create a new Incoming Webhook integration at `https://team-name.slack.com/services/new/incoming-webhook` (where "team-name" should be your own team name).

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
poster.send_message('Hello with options')
# posts message 'Hello with options' to #random with the username 'Tester'
```

Or you can change the options whenever you want

```ruby
poster = Slack::Poster.new(YOUR_WEBHOOK_URL)
poster.username = 'TestUser'
poster.icon_emoji = ':ghost:'
poster.send_message('Hello World') # => "ok"
# posts message 'Hello World' to #random with the username 'TestUser' and ghost emoji as avatar
```

You can also send a `Slack::Message` object instead of `String`:

```ruby
message = Slack::Message.new('hello slack')
poster.send_message(message)
```

### Message attachments

Slack Poster supports message attachments. To do so you have to create `Slack::Attachment` objects
and then attach them to a `Slack::Message` object. Read the [official documentation](https://api.slack.com/docs/attachments) to understand how attachments work and see different examples of attachments in practice.

You can build a basic attachment and them attach it to a message and use a poster to post that
message for you:

```ruby
# As an alternative you could also initialize the attachment with all the fields
# Slack::Attachment.new(fallback: 'fallback', pretext: 'pretext', ....)
attachment = Slack::Attachment.new

# This text will be used in clients that don't show formatted text (eg. IRC, mobile notifications)
attachment.fallback = "You wouldn't believe who's a mighty pirate!"

attachment.pretext = 'Arrrgh'
attachment.color = 'danger' # good, warning, danger, or any hex color code (eg. #439FE0)

attachment.image_url = 'https://pbs.twimg.com/profile_images/446438045945180162/KH34Nkuq.jpeg'
# you can use thumb_url instead for a small thumb pulled to the right

attachment.text = 'To become a mighty pirate Guybrush had to go through the three trials.'
attachment.title = 'Mighty pirate'
attachment.title_link = 'http://scummbar.com/'

# If you want to include author information you can use the following methods:
# attachment.author_name
# attachment.author_icon
# attachment.author_link
# Check Slack documentation for more info.

message = Slack::Message.new('Monkey island news', attachment)

# You can also add the attachment after initializing the message:
# message = Slack::Message.new('Monkey island news')
# message.attachments << attachment

poster = Slack::Poster.new(YOUR_WEBHOOK_URL)
poster.username = 'Monkey Island Daily'
poster.icon_emoji = ':monkey_face:'
poster.send_message(message) # => "ok"
```

This will create a message like this one:

![](http://f.cl.ly/items/2S0E03450f2d3h2Y2w26/guybrush1.png)

#### Fields

Slack attachment can contain fields that will be displayed in a table inside the message attachment.
You can add fields with `Slack::Attachment#add_field`:

```ruby
attachment = Slack::Attachment.new
attachment.add_field('Name1', 'Value1')
attachment.add_field('Name2', 'Value2')
attachment.add_field('Name3', 'Value3')
attachment.add_field('Name4', 'Value4')

message = Slack::Message.new('What a beautiful table of names and values', attachment)

poster = Slack::Poster.new(YOUR_WEBHOOK_URL)
poster.send_message(message) # => "ok"
```

You may notice that the message will display with a vertical list of fields. You can have them side
by side giving a third boolean parameter (is it a short field?).

```ruby
attachment = Slack::Attachment.new
attachment.add_field('Name1', 'Value1', true)
attachment.add_field('Name2', 'Value2', true)
attachment.add_field('Name3', 'Value3')
attachment.add_field('Name4', 'Value4')
```

This way the first two field will be displayed in the same row.

## Contributing

1. Fork it ( http://github.com/rikas/slack-poster/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
