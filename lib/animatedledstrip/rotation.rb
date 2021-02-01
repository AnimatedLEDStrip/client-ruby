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

class DegreesRotation
  attr_accessor :x_rotation, :y_rotation, :z_rotation, :rotation_order

  def initialize(x_rotation = 0.0, y_rotation = 0.0, z_rotation = 0.0,
                 rotation_order = %w[ROTATE_Z, ROTATE_X])
    @x_rotation = x_rotation
    @y_rotation = y_rotation
    @z_rotation = z_rotation
    @rotation_order = rotation_order
  end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :xRotation => self.x_rotation,
        :yRotation => self.y_rotation,
        :zRotation => self.z_rotation,
        :rotationOrder => self.rotation_order
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['xRotation'], object['yRotation'], object['zRotation'], object['rotationOrder'])
  end
end

class RadiansRotation
  attr_accessor :x_rotation, :y_rotation, :z_rotation, :rotation_order

  def initialize(x_rotation = 0.0, y_rotation = 0.0, z_rotation = 0.0,
                 rotation_order = %w[ROTATE_Z, ROTATE_X])
    @x_rotation = x_rotation
    @y_rotation = y_rotation
    @z_rotation = z_rotation
    @rotation_order = rotation_order
  end

  def to_json(*args)
    {
        JSON.create_id => self.class.name,
        :xRotation => self.x_rotation,
        :yRotation => self.y_rotation,
        :zRotation => self.z_rotation,
        :rotationOrder => self.rotation_order
    }.to_json(*args)
  end

  def self.json_create(object)
    new(object['xRotation'], object['yRotation'], object['zRotation'], object['rotationOrder'])
  end
end
