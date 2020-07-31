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
require_relative "../../lib/animatedledstrip/animation_data"

class AnimationDataTest < Minitest::Test
  def test_initialization
    anim = AnimationData.new

    assert_equal "Color", anim.animation
    assert_equal(-1, anim.center)
    assert_nil anim.continuous
    assert_equal(-1, anim.delay)
    assert_equal 1.0, anim.delay_mod
    assert_equal Direction::FORWARD, anim.direction
    assert_equal(-1, anim.distance)
    assert_equal "", anim.id
    assert_equal "", anim.section
    assert_equal(-1, anim.spacing)
  end

  def test_add_color
    cc = ColorContainer.new
    cc.add_color(0xFF)

    anim = AnimationData.new
    anim.add_color(cc)

    assert anim.colors.include? cc

    assert_raises TypeError do
      anim.add_color(0xFF)
    end
  end

  def test_json
    anim = AnimationData.new
    anim.animation = "Meteor"
    anim.center = 50
    anim.continuous = false
    anim.delay = 10
    anim.delay_mod = 1.5
    anim.direction = Direction::BACKWARD
    anim.distance = 45
    anim.id = "TEST"
    anim.section = "SECT"
    anim.spacing = 5

    cc = ColorContainer.new
    cc2 = ColorContainer.new
    cc.add_color 0xFF
    cc.add_color 0xFF00
    cc2.add_color 0xFF0000

    anim.add_color cc
    anim.add_color cc2

    assert_equal 'DATA:{"animation":"Meteor","colors":[{'\
    '"colors":[255,65280]},{"colors":[16711680]}],"center":50,'\
    '"continuous":false,"delay":10,"delayMod":1.5,'\
    '"direction":"BACKWARD","distance":45,'\
    '"id":"TEST","section":"SECT","spacing":5}', anim.json
  end

  def test_json_animation_failure
    anim = AnimationData.new

    anim.animation = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_center_failure
    anim = AnimationData.new

    anim.center = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_continuous_failure
    anim = AnimationData.new

    anim.continuous = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_delay_failure
    anim = AnimationData.new

    anim.delay = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_delay_mod_failure
    anim = AnimationData.new

    anim.delay_mod = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_direction_failure
    anim = AnimationData.new

    anim.direction = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_distance_failure
    anim = AnimationData.new

    anim.distance = "A"
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_id_failure
    skip
    anim = AnimationData.new

    anim.id = nil
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_section_failure
    skip
    anim = AnimationData.new

    anim.section = nil
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_spacing_failure
    anim = AnimationData.new

    anim.spacing = ""
    assert_raises TypeError do
      anim.json
    end
  end

  def test_json_colors_failure
    anim = AnimationData.new

    anim.colors = anim.colors.append "A"

    assert_raises TypeError do
      anim.json
    end

    anim.colors = "A"
    assert_raises TypeError do
      anim.json
    end
  end
end
