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
require_relative "../../lib/animatedledstrip/section"

class SectionTest < Minitest::Test
  def test_initialization
    sect = Section.new

    assert_equal "", sect.name
    assert_equal 0, sect.num_leds
    assert_equal -1, sect.start_pixel
    assert_equal -1, sect.end_pixel
    assert_equal -1, sect.physical_start
  end

  def test_json
    sect = Section.new
    sect.name = "Sect"
    sect.start_pixel = 5
    sect.end_pixel = 20

    assert_equal 'SECT:{"name":"Sect","startPixel":5,"endPixel":20}', sect.json
  end

  def test_json_name_failure
    sect = Section.new

    sect.name = 5
    assert_raises TypeError do
      sect.json
    end
  end

  def test_json_start_pixel_failure
    sect = Section.new

    sect.start_pixel = ""
    assert_raises TypeError do
      sect.json
    end
  end

  def test_json_end_pixel_failure
    sect = Section.new

    sect.end_pixel = ""
    assert_raises TypeError do
      sect.json
    end
  end

  def test_from_json
    json_str = '{"physicalStart":0,"numLEDs":240,"name":"Sect","startPixel":0,"endPixel":239}'

    sect = Section.new_from_json JSON.parse(json_str)

    assert_equal "Sect", sect.name
    assert_equal 240, sect.num_leds
    assert_equal 0, sect.start_pixel
    assert_equal 239, sect.end_pixel
    assert_equal 0, sect.physical_start
  end
end
