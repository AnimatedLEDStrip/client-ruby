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
require_relative "../../lib/animatedledstrip/animation_info"
require_relative "../../lib/animatedledstrip/als_http_client"

class AnimationInfoTest < Minitest::Test
  def test_new
    # info = AnimationInfo.new
    # info.name = 'abf'
    #
    # puts info.to_json
    # puts 'a'

    s = ALSHttpClient.new('10.0.0.91')
    # a = s.get_animation_info( "pixel run")
    # puts s.get_supported_animations_hash
    # puts s.get_running_animation_params('22004510')
    # puts s.end_animation('22004510')
    puts s.get_section 'fullStrip'
    puts s.get_sections_hash
    # sect = Section.new("sect2", [5, 6, 7, 8, 9, 14])
    # puts s.create_new_section(sect)
    anim = AnimationToRunParams.new("pixel run", [ColorContainer.new([0xFF00])])
    puts s.start_animation(anim)
    puts s.get_current_strip_color
    s.clear_strip
    # puts a.int_params.length
    # puts s.get_animation_info("fireworks")
    # puts s.get_supported_animations_map
    # puts 'b'

  end

  def test_initialization
    info = AnimationInfo.new

    assert_equal "", info.name
    assert_equal "", info.abbr
    assert_equal "", info.description
    assert_equal "", info.signature_file
    assert_equal false, info.repetitive
    assert_equal 0, info.minimum_colors
    assert_equal false, info.unlimited_colors
    assert_equal ParamUsage::NOTUSED, info.center
    assert_equal ParamUsage::NOTUSED, info.delay
    assert_equal ParamUsage::NOTUSED, info.direction
    assert_equal ParamUsage::NOTUSED, info.distance
    assert_equal ParamUsage::NOTUSED, info.spacing
    assert_equal 50, info.delay_default
    assert_equal(-1, info.distance_default)
    assert_equal 3, info.spacing_default
  end

  def test_from_json
    json_str = '{"name":"Meteor","abbr":"MET","description":"A description",'\
               '"signatureFile":"meteor.png","repetitive":true,"minimumColors":1,'\
               '"unlimitedColors":false,"center":"NOTUSED","delay":"USED",'\
               '"direction":"USED","distance":"NOTUSED","spacing":"NOTUSED",'\
               '"delayDefault":10,"distanceDefault":-1,"spacingDefault":3}'

    info = AnimationInfo.new_from_json JSON.parse(json_str)

    assert_equal "Meteor", info.name
    assert_equal "MET", info.abbr
    assert_equal "A description", info.description
    assert_equal "meteor.png", info.signature_file
    assert_equal true, info.repetitive
    assert_equal 1, info.minimum_colors
    assert_equal false, info.unlimited_colors
    assert_equal ParamUsage::NOTUSED, info.center
    assert_equal ParamUsage::USED, info.delay
    assert_equal ParamUsage::USED, info.direction
    assert_equal ParamUsage::NOTUSED, info.distance
    assert_equal ParamUsage::NOTUSED, info.spacing
    assert_equal 10, info.delay_default
    assert_equal(-1, info.distance_default)
    assert_equal 3, info.spacing_default
  end
end
