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

class Section
  attr_accessor :name, :num_leds, :start_pixel,
                :end_pixel, :physical_start

  def initialize
    @name = ""
    @num_leds = 0
    @start_pixel = -1
    @end_pixel = -1
    @physical_start = -1
  end

  def json
    raise TypeError unless @name.is_a? String
    raise TypeError unless @num_leds.is_a? Integer
    raise TypeError unless @start_pixel.is_a? Integer
    raise TypeError unless @end_pixel.is_a? Integer
    raise TypeError unless @physical_start.is_a? Integer

    "SECT:{\"name\":\"#{@name}\",\"numLEDs\":#{@num_leds},"\
    "\"startPixel\":#{@start_pixel},\"endPixel\":#{@end_pixel},"\
    "\"physicalStart\":#{@physical_start}}"
  end

  def self.new_from_json(json_data)
    sect = Section.new
    sect.name = json_data["name"] unless json_data["name"].nil?
    sect.num_leds = json_data["numLEDs"] unless json_data["numLEDs"].nil?
    sect.start_pixel = json_data["startPixel"] unless json_data["startPixel"].nil?
    sect.end_pixel = json_data["endPixel"] unless json_data["endPixel"].nil?
    sect.physical_start = json_data["physicalStart"] unless json_data["physicalStart"].nil?

    sect
  end
end