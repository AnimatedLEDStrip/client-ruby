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

require 'httparty'
require 'json'
require_relative 'als_json_decode'

JSON.create_id = 'type'

class ALSHttpClient
  attr_accessor :ip_address

  def initialize(ip_address)
    @ip_address = ip_address
  end

  def resolve_path(path)
    escaped_path = URI.escape(path)
    "http://#{self.ip_address}:8080#{escaped_path}"
  end

  def get(path)
    r = HTTParty.get(path)
    if r.code != 200
      throw "GET to #{path} returned #{r.code}"
    else
      r.body
    end
  end

  def post(path, post_body)
    r = HTTParty.post(path, body: post_body, headers: {'Content-Type' => 'application/json'})
    if r.code != 200
      throw "POST to #{path} returned #{r.code} (body #{post_body})"
    else
      r.body
    end
  end

  def delete(path)
    r = HTTParty.delete(path)
    if r.code != 200
      throw "DELETE to #{path} returned #{r.code}"
    else
      r.body
    end
  end

  def get_animation_info(name)
    ALSJsonDecode.load_object(get(resolve_path("/animation/#{name}")), 'AnimationInfo')
  end

  def get_supported_animations
    ALSJsonDecode.load_list_with_type(get(resolve_path('/animations')), 'AnimationInfo')
  end

  def get_supported_animations_names
    JSON.parse(get(resolve_path('/animations/names')))
  end

  def get_supported_animations_map
    ALSJsonDecode.load_hash_with_type(get(resolve_path('/animations/map')), 'AnimationInfo')
  end

  def get_supported_animations_hash
    get_supported_animations_map
  end

  def get_running_animations
    ALSJsonDecode.load_hash_with_type(get(resolve_path('/running')), 'RunningAnimationParams')
  end

  def get_running_animations_ids
    JSON.parse(get(resolve_path('/running/ids')))
  end

  def get_running_animation_params(id)
    ALSJsonDecode.load_object(get(resolve_path("/running/#{id}")), 'RunningAnimationParams')
  end

  def end_animation(id)
    ALSJsonDecode.load_object(delete(resolve_path("/running/#{id}")), 'RunningAnimationParams')
  end

  def end_animation_from_params(params)
    end_animation(params.id)
  end

  def get_sections
    ALSJsonDecode.load_list_with_type(get(resolve_path('/sections')), 'Section')
  end

  def get_sections_map
    ALSJsonDecode.load_hash_with_type(get(resolve_path('/sections/map')), 'Section')
  end

  def get_sections_hash
    get_sections_map
  end

  def get_section(name)
    ALSJsonDecode.load_object(get(resolve_path("/section/#{name}")), 'Section')
  end

  def get_full_strip_section
    get_section('fullStrip')
  end

  def create_new_section(section)
    ALSJsonDecode.load_object(post(resolve_path('/sections'), section.to_json), 'Section')
  end

  def start_animation(anim_params)
    ALSJsonDecode.load_object(post(resolve_path('/start'), anim_params.to_json), 'RunningAnimationParams')
  end

  def get_strip_info
    ALSJsonDecode.load_object(get(resolve_path('/strip/info')), 'StripInfo')
  end

  def get_current_strip_color
    JSON.parse(get(resolve_path('/strip/color')))
  end

  def clear_strip
    # TODO: Fix 404
    post(resolve_path('/strip/clear'), {})
  end
end
