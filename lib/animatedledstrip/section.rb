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
  attr_accessor :name, :pixels, :parent_section_name

  def initialize(name = '', pixels = [], parent_section_name = '')
    @name = name
    @pixels = pixels
    @parent_section_name = parent_section_name
  end

  # def json
  #   raise TypeError unless @name.is_a? String
  #   raise TypeError unless @start_pixel.is_a? Integer
  #   raise TypeError unless @end_pixel.is_a? Integer
  #
  #   "SECT:{\"name\":\"#{@name}\","\
  #   "\"startPixel\":#{@start_pixel},\"endPixel\":#{@end_pixel}}"
  # end
  #
  # def self.new_from_json(json_data)
  #   sect = Section.new
  #   sect.name = json_data["name"] unless json_data["name"].nil?
  #   sect.num_leds = json_data["numLEDs"] unless json_data["numLEDs"].nil?
  #   sect.start_pixel = json_data["startPixel"] unless json_data["startPixel"].nil?
  #   sect.end_pixel = json_data["endPixel"] unless json_data["endPixel"].nil?
  #   sect.physical_start = json_data["physicalStart"] unless json_data["physicalStart"].nil?
  #
  #   sect
  # end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :name => self.name,
        :pixels => self.pixels,
        :parentSectionName => self.parent_section_name
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['name'], object['pixels'], object['parentSectionName'])
  end
end
