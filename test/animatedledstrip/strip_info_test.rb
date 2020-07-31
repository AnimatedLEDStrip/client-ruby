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
require_relative "../../lib/animatedledstrip/strip_info"

class StripInfoTest < Minitest::Test
  def test_initialization
    info = StripInfo.new

    assert_equal 0, info.num_leds
    assert_equal( -1, info.pin)
    assert_equal false, info.image_debugging
    assert_equal "", info.file_name
    assert_equal(-1, info.renders_before_save)
    assert_equal 100, info.thread_count
  end

  def test_from_json
    json_str = '{"numLEDs":240,"pin":12,"imageDebugging":true,"rendersBeforeSave":1000,"threadCount":200}'

    info = StripInfo.new_from_json JSON.parse(json_str)

    assert_equal 240, info.num_leds
    assert_equal 12, info.pin
    assert_equal true, info.image_debugging
    assert_equal 1000, info.renders_before_save
    assert_equal 200, info.thread_count
  end
end
