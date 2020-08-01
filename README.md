# AnimatedLEDStrip Client Library for Ruby

[![Build Status](https://travis-ci.com/AnimatedLEDStrip/client-ruby.svg?branch=master)](https://travis-ci.com/AnimatedLEDStrip/client-ruby)
[![Gem Version](https://badge.fury.io/rb/animatedledstrip-client.svg)](https://badge.fury.io/rb/animatedledstrip-client)
[![codecov](https://codecov.io/gh/AnimatedLEDStrip/client-ruby/branch/master/graph/badge.svg)](https://codecov.io/gh/AnimatedLEDStrip/client-ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'animatedledstrip-client'
```

Or install with:

    $ gem install animatedledstrip-client

## Creating an `AnimationSender`
An `AnimationSender` is constructed with two arguments:
- `host`: The IP address of the server (as a string)
- `port`: The port that the client should connect to (as an integer)

```ruby
sender = AnimationSender.new("10.0.0.254", 5);
```

## Starting the `AnimationSender`
An `AnimationSender` is started by calling the `start()` method on the instance.

```ruby
sender.start
```

## Stopping the `AnimationSender`
To stop the `AnimationSender`, call its `end()` method.

```ruby
sender.end
```

## Sending Data

### AnimationData
An animation can be sent to the server by creating an `AnimationData` instance, then calling `send_animation` with the instance as the argument.

```ruby
cc = ColorContainer.new
cc.add_color 0xFF
cc.add_color 0xFF00

data = AnimationData.new
data.add_color cc

sender.send_animation data
```

### EndAnimation
The end of an animation can be sent to the server by creating an `EndAnimation` instance, then calling `send_end_animation` with the instance as the argument.

```ruby
end_anim = EndAnimation.new
end_anim.id = "ANIM_ID"

sender.send_end_animation end_anim
```

### Section
A new section can be sent to the server by creating a `Section` instance, then calling `send_section` with the instance as the argument.
Note that changing `num_leds` or `physical_start` will have no effect on the new section.

```ruby
sect = Section.new
sect.name = "SECTION"
sect.start_pixel = 5
sect.end_pixel = 30

sender.send_section sect
```

#### `AnimationData` type notes
The Ruby library uses the following values for `continuous` and `direction`:
- `continuous`: `nil`, `true`, `false`
- `direction`: `Direction::FORWARD`, `Direction::BACKWARD`

## Receiving Data

### Supported Animations
Supported animations are stored in the sender's `supported_animations` hash.

### Running Animations
Running animations are stored in the sender's `running_animations` hash.

### Ending Animations
Animations are removed from the sender's `running_animations` hash.

### New Section
Sections are stored in the sender's `sections` hash.

### Strip Info
The strip's info is stored in the sender's `strip_info` attribute.
