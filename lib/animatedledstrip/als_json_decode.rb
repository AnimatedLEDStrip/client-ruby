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

require_relative 'animation_info'
require_relative 'animation_to_run_params'
require_relative 'color_container'
require_relative 'distance'
require_relative 'equation'
require_relative 'location'
require_relative 'rotation'
require_relative 'running_animation_params'
require_relative 'section'
require_relative 'strip_info'

class ALSJsonDecode
  def self.add_type_param(data, type)
    #noinspection RubyStringKeysInHashInspection
    data.merge({'type' => type})
  end

  def self.load_hash(hash)
    JSON.load(JSON.dump(hash))
  end

  def self.load_object_from_hash(hash, type)
    load_hash(add_type_param(hash, type))
  end

  def self.load_list_elements(list, type)
    loaded_list = []
    list.each do |o|
      loaded_list.push(load_hash(add_type_param(o, type)))
    end
    loaded_list
  end

  def self.load_hash_elements(hash, type)
    loaded_hash = {}
    hash.each do |k, v|
      loaded_hash[k] = load_hash(add_type_param(v, type))
    end
    loaded_hash
  end

  def self.load_object(data, type)
    load_object_from_hash(JSON.parse(data), type)
  end

  def self.load_list_with_type(data, type)
    json_list = JSON.parse(data)
    load_list_elements(json_list, type)
  end

  def self.load_hash_with_type(data, type)
    json_hash = JSON.parse(data)
    load_hash_elements(json_hash, type)
  end
end
