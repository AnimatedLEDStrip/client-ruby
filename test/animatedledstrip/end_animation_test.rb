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
require_relative "../../lib/animatedledstrip/end_animation"

class EndAnimationTest < Minitest::Test
  def test_initialization
    anim = EndAnimation.new

    assert_equal "", anim.id
  end

  def test_json
    anim = EndAnimation.new
    anim.id = "TEST"

    assert_equal 'END :{"id":"TEST"}', anim.json
  end

  def test_json_id_failure
    anim = EndAnimation.new

    anim.id = 5
    assert_raises TypeError do
      anim.json
    end
  end

  def test_from_json
    json_str = '{"id":"TEST_ANIM"}'

    anim = EndAnimation.new_from_json JSON.parse(json_str)

    assert_equal "TEST_ANIM", anim.id
  end
end