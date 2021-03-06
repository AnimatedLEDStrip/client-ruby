#   Copyright (c) 2018-2021 AnimatedLEDStrip
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

class ColorContainer
  attr_accessor :colors

  def initialize(colors = [])
    @colors = colors
  end

  # # @return [String]
  # def json
  #   @colors.each { |c| raise TypeError unless c.is_a? Integer }
  #   str = '{"colors":['
  #   @colors.each do |c|
  #     str.concat(c.to_s, ',')
  #   end
  #   str.delete_suffix! ','
  #   str + ']}'
  # end

  def add_color(color)
    @colors.push(color)
  end

  # def self.new_from_json(json_str)
  #   cc = ColorContainer.new
  #   json_str["colors"].each { |c| cc.add_color c }
  #
  #   cc
  # end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :colors => self.colors,
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['colors'])
  end

end

class PreparedColorContainer
  attr_accessor :colors, :original_colors

  def initialize(colors = [], original_colors = [])
    @colors = colors
    @original_colors = original_colors
  end

  # # @return [String]
  # def json
  #   @colors.each { |c| raise TypeError unless c.is_a? Integer }
  #   str = '{"colors":['
  #   @colors.each do |c|
  #     str.concat(c.to_s, ',')
  #   end
  #   str.delete_suffix! ','
  #   str + ']}'
  # end

  def add_color(color)
    @colors.push(color)
  end

  # def self.new_from_json(json_str)
  #   cc = ColorContainer.new
  #   json_str["colors"].each { |c| cc.add_color c }
  #
  #   cc
  # end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :colors => self.colors,
        :originalColors => self.original_colors
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['colors'], object['originalColors'])
  end

end
