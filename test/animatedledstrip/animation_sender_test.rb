#   Copyright (c) 2019-2020 AnimatedLEDStrip
#
#   Permission is hereby granted, free of charge, to any person obtaining a copy
#   of this software and associated documentation files (the "Software"), to deal
#   in the Software without restriction, including without limitation the rights
#   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#   copies of the Software, and to permit persons to whom the Software is
#   furnished to do so, subject to the following conditions:
#
#   The above copyright notice and this permission notice shall be included in
#   all copies or substantial portions of the Software.
#
#   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#   THE SOFTWARE.

require_relative "../test_helper"
require "minitest"
require_relative "../../lib/animatedledstrip/animation_sender"

class AnimationSenderTest < Minitest::Test
  def test_initialization
    sender = AnimationSender.new "10.0.0.254", 5

    assert_equal "10.0.0.254", sender.address
    assert_equal 5, sender.port
  end

  def test_send
    sender = AnimationSender.new "10.44.167.23", 6

    assert_equal "10.44.167.23", sender.address
    assert_equal 6, sender.port

    sender.on_connect_callback = lambda { |ip, port| puts "#{ip} #{port}" }

    sender.start

    anim = AnimationData.new
    anim.animation = "Meteor"
    anim.center = 50
    anim.continuous = nil
    anim.delay = 10
    anim.delay_mod = 1.5
    anim.direction = Direction::BACKWARD
    anim.distance = 45
    anim.id = "TEST"
    anim.section = ""
    anim.spacing = 5

    cc = ColorContainer.new
    cc2 = ColorContainer.new
    cc.add_color 0xFF
    cc.add_color 0xFF00
    cc2.add_color 0xFF0000

    anim.add_color cc
    anim.add_color cc2

    sender.send_animation anim

    sleep(2)

    puts sender.strip_info
    puts sender.running_animations

    anim_end = EndAnimation.new
    anim_end.id = sender.running_animations.keys.at 0

    sender.send_end_animation anim_end

    sleep(2)

    puts sender.running_animations
    puts sender.sections

    sect = Section.new
    sect.name = "S"
    sect.start_pixel = 50
    sect.end_pixel = 200

    sender.send_section sect

    sleep(2)

    puts sender.sections
    anim.section = "S"

    sender.send_animation anim

    sleep(2)

    puts sender.running_animations

    anim_end.id = sender.running_animations.keys.at 0

    sender.send_end_animation anim_end

    sleep(2)

    puts sender.running_animations

    sender.end
  end
end
