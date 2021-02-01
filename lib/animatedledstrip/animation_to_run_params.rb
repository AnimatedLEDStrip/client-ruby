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

require_relative 'als_json_decode'

#noinspection RubyTooManyInstanceVariablesInspection
class AnimationToRunParams
  attr_accessor :animation, :colors, :id, :section, :run_count,
                :int_params, :double_params, :string_params,
                :location_params, :distance_params,
                :rotation_params, :equation_params

  def initialize(animation = '', colors = [], id = '', section = '', run_count = 0,
                 int_params = {}, double_params = {}, string_params = {},
                 location_params = {}, distance_params = {},
                 rotation_params = {}, equation_params = {})
    @animation = animation
    @colors = colors
    @id = id
    @section = section
    @run_count = run_count
    @int_params = int_params
    @double_params = double_params
    @string_params = string_params
    @location_params = location_params
    @distance_params = distance_params
    @rotation_params = rotation_params
    @equation_params = equation_params
  end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :animation => self.animation,
        :colors => self.colors,
        :id => self.id,
        :section => self.section,
        :runCount => self.run_count,
        :intParams => self.int_params,
        :doubleParams => self.double_params,
        :stringParams => self.string_params,
        :locationParams => self.location_params,
        :distanceParams => self.distance_params,
        :rotationParams => self.rotation_params,
        :equationParams => self.equation_params
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['animation'], object['colors'], object['id'], object['section'],
        object['runCount'], object['intParams'], object['doubleParams'], object['stringParams'],
        ALSJsonDecode.load_hash_elements(object['locationParams'], 'Location'),
        object['distanceParams'], object['rotationParams'],
        ALSJsonDecode.load_hash_elements(object['equationParams'], 'Equation'))
  end
end