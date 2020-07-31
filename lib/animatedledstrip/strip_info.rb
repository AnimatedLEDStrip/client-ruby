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

class StripInfo
  attr_accessor :num_leds, :pin, :image_debugging,
                :file_name, :renders_before_save,
                :thread_count

  def initialize
    @num_leds = 0
    @pin = -1
    @image_debugging = false
    @file_name = ""
    @renders_before_save = -1
    @thread_count = 100
  end

  def self.new_from_json(json_data)
    info = StripInfo.new
    info.num_leds = json_data["numLEDs"] unless json_data["numLEDs"].nil?
    info.pin = json_data["pin"] unless json_data["pin"].nil?
    info.image_debugging = json_data["imageDebugging"] unless json_data["imageDebugging"].nil?
    info.file_name = json_data["fileName"] unless json_data["fileName"].nil?
    info.renders_before_save = json_data["rendersBeforeSave"] unless json_data["rendersBeforeSave"].nil?
    info.thread_count = json_data["threadCount"] unless json_data["threadCount"].nil?

    info
  end
end
