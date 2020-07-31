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

require_relative 'param_usage'

#noinspection RubyTooManyInstanceVariablesInspection
class AnimationInfo
  attr_accessor :name, :abbr, :description,
                :signature_file, :repetitive,
                :minimum_colors, :unlimited_colors,
                :center, :delay, :direction,
                :distance, :spacing, :delay_default,
                :distance_default, :spacing_default

  def initialize
    @name = ''
    @abbr = ''
    @description = ''
    @signature_file = ''
    @repetitive = false
    @minimum_colors = 0
    @unlimited_colors = false
    @center = ParamUsage::NOTUSED
    @delay = ParamUsage::NOTUSED
    @direction = ParamUsage::NOTUSED
    @distance = ParamUsage::NOTUSED
    @spacing = ParamUsage::NOTUSED
    @delay_default = 50
    @distance_default = -1
    @spacing_default = 3
  end

  def self.new_from_json(json_data)
    info = AnimationInfo.new
    info.name = json_data["name"] unless json_data["name"].nil?
    info.abbr = json_data["abbr"] unless json_data["abbr"].nil?
    info.description = json_data["description"] unless json_data["description"].nil?
    info.signature_file = json_data["signatureFile"] unless json_data["signatureFile"].nil?
    info.repetitive = json_data["repetitive"] unless json_data["repetitive"].nil?
    info.minimum_colors = json_data["minimumColors"] unless json_data["minimumColors"].nil?
    info.unlimited_colors = json_data["unlimitedColors"] unless json_data["unlimitedColors"].nil?
    info.center = ParamUsage::from_string(json_data["center"]) unless json_data["center"].nil?
    info.delay = ParamUsage::from_string(json_data["delay"]) unless json_data["delay"].nil?
    info.direction = ParamUsage::from_string(json_data["direction"]) unless json_data["direction"].nil?
    info.distance = ParamUsage::from_string(json_data["distance"]) unless json_data["distance"].nil?
    info.spacing = ParamUsage::from_string(json_data["spacing"]) unless json_data["spacing"].nil?
    info.delay_default = json_data["delayDefault"] unless json_data["delayDefault"].nil?
    info.distance_default = json_data["distanceDefault"] unless json_data["distanceDefault"].nil?
    info.spacing_default = json_data["spacingDefault"] unless json_data["spacingDefault"].nil?

    info
  end

end