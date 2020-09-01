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
require_relative "message"
require_relative "section"
require_relative "strip_info"

#noinspection RubyTooManyInstanceVariablesInspection
class AnimationSender
  attr_accessor :address, :port, :started, :connected,
                :running_animations, :sections,
                :supported_animations, :strip_info,
                :on_connect_callback, :on_disconnect_callback,
                :on_unable_to_connect_callback, :on_receive_callback,
                :on_new_animation_data_callback,
                :on_new_animation_info_callback,
                :on_new_end_animation_callback,
                :on_new_message_callback,
                :on_new_section_callback,
                :on_new_strip_info_callback

  def initialize(address, port)
    @address = address
    @port = port
    @running_animations = {}
    @supported_animations = {}
    @sections = {}
  end

  def start
    return if @started

    @running_animations = {}
    @sections = {}
    @supported_animations = {}
    @strip_info = nil

    @started = true

    begin
      @connection = Socket.tcp @address, @port, nil, nil, {
          connect_timeout: 2
      }
    rescue SocketError
      @on_unable_to_connect_callback.call(@address, @port)
      @started = false
      @connected = false
      return
    end

    @connected = true
    @on_connect_callback.call(@address, @port)

    @receive_thread = Thread.new { receive_data }
  end

  #noinspection RubyUnusedLocalVariable
  def end
    return unless @connected
    @started = false
    @connected = false
    #noinspection RubyNilAnalysis
    @connection.close
    @receive_thread.join
  end

  def receive_data
    begin
      while (line = @connection.gets ";;;")
        process_data line
      end
    rescue IOError
      @started = false
      @connected = false
      @on_disconnect_callback.call(address, port)
    end
  end

  def process_data(line)
    line = line.delete_suffix ";;;"

    @on_receive_callback.call line

    if line.start_with? "DATA:"
      data = AnimationData::new_from_json JSON.parse(line.delete_prefix "DATA:")
      @on_new_animation_data_callback.call data
      @running_animations[data.id] = data
    elsif line.start_with? "AINF:"
      info = AnimationInfo.new_from_json JSON.parse(line.delete_prefix "AINF:")
      @supported_animations[info.name] = info
      @on_new_animation_info_callback.call info
    elsif line.start_with? "CMD :"
      puts "Receiving Command is not supported by client"
    elsif line.start_with? "END :"
      anim = EndAnimation.new_from_json JSON.parse(line.delete_prefix "END :")
      @on_new_end_animation_callback.call anim
      @running_animations.delete anim.id
    elsif line.start_with? "MSG :"
      msg = Message.new_from_json JSON.parse(line.delete_prefix "MSG :")
      @on_new_message_callback.call msg
    elsif line.start_with? "SECT:"
      sect = Section.new_from_json JSON.parse(line.delete_prefix "SECT:")
      @on_new_section_callback.call sect
      @sections[sect.name] = sect
    elsif line.start_with? "SINF:"
      info = StripInfo.new_from_json JSON.parse(line.delete_prefix "SINF:")
      @strip_info = info
      @on_new_strip_info_callback.call info
    else
      puts "Unrecognized data type: #{line[0, 4]}"
    end
  end

  def send(data)
    raise IOError("Sender must be started") unless @started
    raise IOError("Sender is not connected") unless @connected

    #noinspection RubyNilAnalysis
    @connection.write(data + ";;;")
  end

  def send_animation(animation)
    raise TypeError unless animation.is_a? AnimationData

    send(animation.json)
  end

  def send_command(command)
    raise TypeError unless command.is_a? Command

    send(command.json)
  end

  def send_end_animation(end_animation)
    raise TypeError unless end_animation.is_a? EndAnimation

    send(end_animation.json)
  end

  def send_section(section)
    raise TypeError unless section.is_a? Section

    send(section.json)
  end

end
