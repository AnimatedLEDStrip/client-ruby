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

require_relative 'als_json_decode'

#noinspection RubyTooManyInstanceVariablesInspection
class StripInfo
  attr_accessor :num_leds, :pin, :render_delay,
                :is_render_logging_enabled, :render_log_file,
                :renders_between_log_saves, :is_1d_supported,
                :is_2d_supported, :is_3d_supported, :led_locations

  #noinspection RubyParameterNamingConvention
  def initialize(num_leds = 0, pin = nil, render_delay = 10, is_render_logging_enabled = false,
                 render_log_file = '', renders_between_log_saves = 1000, is_1d_supported = true,
                 is_2d_supported = false, is_3d_supported = false, led_locations = nil)
    @num_leds = num_leds
    @pin = pin
    @render_delay = render_delay
    @is_render_logging_enabled = is_render_logging_enabled
    @render_log_file = render_log_file
    @renders_between_log_saves = renders_between_log_saves
    @is_1d_supported = is_1d_supported
    @is_2d_supported = is_2d_supported
    @is_3d_supported = is_3d_supported
    @led_locations = led_locations
  end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :numLEDs => self.num_leds,
        :pin => self.pin,
        :renderDelay => self.render_delay,
        :isRenderLoggingEnabled => self.is_render_logging_enabled,
        :renderLogFile => self.render_log_file,
        :rendersBetweenLogSaves => self.renders_between_log_saves,
        :is1DSupported => self.is_1d_supported,
        :is2DSupported => self.is_2d_supported,
        :is3DSupported => self.is_3d_supported,
        :ledLocations => self.led_locations
    }.to_json(*args)
  end

  def self.json_create(object)
    locations = nil
    locations = ALSJsonDecode.load_list_elements(object['ledLocations'], 'Location') unless object['ledLocations'].nil?
    new(object['numLEDs'], object['pin'], object['renderDelay'], object['isRenderLoggingEnabled'],
        object['renderLogFile'], object['rendersBetweenLogSaves'], object['is1DSupported'],
        object['is2DSupported'], object['is3DSupported'], locations)
  end
end
