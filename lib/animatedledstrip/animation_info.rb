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

require_relative 'param_usage'
require_relative 'als_json_decode'

class AnimationParameter
  attr_accessor :name, :description, :default

  def initialize(name = '', description = '', default = nil)
    @name = name
    @description = description
    @default = default
  end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :name => self.name,
        :description => self.description,
        :default => self.default
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['name'], object['description'], ALSJsonDecode.load_hash(object['default']))
  end
end

#noinspection RubyTooManyInstanceVariablesInspection
class AnimationInfo
  attr_accessor :name, :abbr, :description, :run_count_default,
                :minimum_colors, :unlimited_colors, :dimensionality,
                :int_params, :double_params, :string_params,
                :location_params, :distance_params,
                :rotation_params, :equation_params

  def initialize(name = '', abbr = '', description = '', run_count_default = 0,
                 minimum_colors = 0, unlimited_colors = false, dimensionality = [],
                 int_params = [], double_params = [], string_params = [],
                 location_params = [], distance_params = [],
                 rotation_params = [], equation_params = [])
    @name = name
    @abbr = abbr
    @description = description
    @run_count_default = run_count_default
    @minimum_colors = minimum_colors
    @unlimited_colors = unlimited_colors
    @dimensionality = dimensionality
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
        :name => self.name,
        :abbr => self.abbr,
        :description => self.description,
        :runCountDefault => self.run_count_default,
        :minimumColors => self.minimum_colors,
        :unlimited_colors => self.unlimited_colors,
        :dimensionality => self.dimensionality,
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
    new(object['name'], object['abbr'], object['description'], object['runCountDefault'],
        object['minimumColors'], object['unlimitedColors'], object['dimensionality'],
        ALSJsonDecode.load_list_elements(object['intParams'], 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(object['doubleParams'], 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(object['stringParams'], 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(prepare_param_list(object['locationParams'], 'Location'), 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(object['distanceParams'], 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(object['rotationParams'], 'AnimationParameter'),
        ALSJsonDecode.load_list_elements(prepare_param_list(object['equationParams'], 'Equation'), 'AnimationParameter'))
  end

  private

  def self.prepare_param_list(list, type)
    prepared_list = []
    list.each do |i|
      if defined? i.type
        i['type'] = type
        prepared_list.push(i)
      else
        prepared_list.push(i)
      end
    end
    prepared_list
  end

  # def self.new_from_json(json_data)
  #   info = AnimationInfo.new
  #   info.name = json_data["name"] unless json_data["name"].nil?
  #   info.abbr = json_data["abbr"] unless json_data["abbr"].nil?
  #   info.description = json_data["description"] unless json_data["description"].nil?
  #   info.signature_file = json_data["signatureFile"] unless json_data["signatureFile"].nil?
  #   info.repetitive = json_data["repetitive"] unless json_data["repetitive"].nil?
  #   info.minimum_colors = json_data["minimumColors"] unless json_data["minimumColors"].nil?
  #   info.unlimited_colors = json_data["unlimitedColors"] unless json_data["unlimitedColors"].nil?
  #   info.center = ParamUsage::from_string(json_data["center"]) unless json_data["center"].nil?
  #   info.delay = ParamUsage::from_string(json_data["delay"]) unless json_data["delay"].nil?
  #   info.direction = ParamUsage::from_string(json_data["direction"]) unless json_data["direction"].nil?
  #   info.distance = ParamUsage::from_string(json_data["distance"]) unless json_data["distance"].nil?
  #   info.spacing = ParamUsage::from_string(json_data["spacing"]) unless json_data["spacing"].nil?
  #   info.delay_default = json_data["delayDefault"] unless json_data["delayDefault"].nil?
  #   info.distance_default = json_data["distanceDefault"] unless json_data["distanceDefault"].nil?
  #   info.spacing_default = json_data["spacingDefault"] unless json_data["spacingDefault"].nil?
  #
  #   info
  # end

end