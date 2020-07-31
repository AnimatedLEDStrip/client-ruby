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

require "json"
require "socket"
require_relative "animation_data"
require_relative "animation_info"
require_relative "end_animation"
require_relative "strip_info"

class AnimationSender
  attr_accessor :address, :port, :strip_info,
                :running_animations, :supported_animations

  def initialize(address, port)
    @address = address
    @port = port
    @running_animations = {}
    @supported_animations = {}
  end

  def start
    @socket = TCPSocket.new @address, @port
    @receive_thread = Thread.new {
      begin
        while (line = @socket.gets ";;;")
          if line.start_with? "DATA:"
            json = JSON.parse (line.delete_prefix "DATA:").delete_suffix(";;;")
            data = AnimationData::new_from_json json
            @running_animations[data.id] = data
          elsif line.start_with? "AINF:"
            json = JSON.parse (line.delete_prefix "AINF:").delete_suffix(";;;")
            info = AnimationInfo.new_from_json json
            @supported_animations[info.name] = info
          elsif line.start_with? "END :"
            json = JSON.parse (line.delete_prefix "END :").delete_suffix(";;;")
            anim = EndAnimation.new_from_json json
            @running_animations.delete anim.id
          elsif line.start_with? "SINF:"
            json = JSON.parse (line.delete_prefix "SINF:").delete_suffix(";;;")
            info = StripInfo.new_from_json json
            @strip_info = info
          end
        end
      rescue IOError
# ignored
      end
    }
  end

  def end
    @socket.close
    @receive_thread.join
  end

  def send_animation(animation)
    raise TypeError unless animation.is_a? AnimationData

    @socket.write(animation.json + ";;;")
  end

  def send_end_animation(end_animation)
    raise TypeError unless end_animation.is_a? EndAnimation

    @socket.write(end_animation.json + ";;;")

  end

end
