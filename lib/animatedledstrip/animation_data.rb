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

require_relative "direction"
require_relative "color_container"

#noinspection RubyTooManyInstanceVariablesInspection
class AnimationData
  attr_accessor :animation, :colors, :center,
                :continuous, :delay, :delay_mod,
                :direction, :distance, :id,
                :section, :spacing

  def initialize
    @animation = "Color"
    @colors = []
    @center = -1
    @continuous = nil
    @delay = -1
    @delay_mod = 1.0
    @direction = Direction::FORWARD
    @distance = -1
    @id = ""
    @section = ""
    @spacing = -1
  end

  def add_color(color)
    raise TypeError unless color.is_a? ColorContainer

    colors.push(color)
  end

  # @return [String]
  def json
    raise TypeError unless @animation.is_a? String
    raise TypeError unless @colors.is_a? Array
    raise TypeError unless @center.is_a? Integer
    unless @continuous.is_a?(TrueClass) || @continuous.is_a?(FalseClass) || @continuous.nil?
      raise TypeError
    end
    raise TypeError unless @delay.is_a? Integer
    raise TypeError unless @delay_mod.is_a? Float
    raise TypeError unless @direction.is_a? Integer
    raise TypeError unless @distance.is_a? Integer
    raise TypeError unless @id.is_a? String
    raise TypeError unless @section.is_a? String
    raise TypeError unless @spacing.is_a? Integer

    @colors.each { |cc| raise TypeError unless cc.is_a? ColorContainer }

    str = "DATA:{\"animation\":\"#{@animation}\","\
    '"colors":['
    @colors.each { |cc| str += "#{cc.json}," }
    str.delete_suffix! ','
    str += '],'\
    "\"center\":#{@center},"\
    "\"continuous\":#{@continuous.nil? ? 'null' : @continuous},"\
    "\"delay\":#{@delay},"\
    "\"delayMod\":#{delay_mod},"\
    "\"direction\":\"#{Direction.string(@direction)}\","\
    "\"distance\":#{@distance},"\
    "\"id\":\"#{@id}\","\
    "\"section\":\"#{section}\","\
    "\"spacing\":#{@spacing}}"

    str
  end

  def self.new_from_json(json_data)
    data = AnimationData.new
    data.animation = json_data["animation"] unless json_data["animation"].nil?
    json_data["colors"].each { |cc| data.add_color(ColorContainer.new_from_json cc) }
    data.center = json_data["center"] unless json_data["center"].nil?
    data.continuous = json_data["continuous"]
    data.delay = json_data["delay"] unless json_data["delay"].nil?
    data.delay_mod = json_data["delayMod"] unless json_data["delayMod"].nil?
    data.direction = Direction::from_string(json_data["direction"]) unless json_data["direction"].nil?
    data.distance = json_data["distance"] unless json_data["distance"].nil?
    data.id = json_data["id"] unless json_data["id"].nil?
    data.section = json_data["section"] unless json_data["section"].nil?
    data.spacing = json_data["spacing"] unless json_data["spacing"].nil?

    data
  end
end
