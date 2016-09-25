# frozen_string_literal: true

###
# This class responsible for the storage of the bitmap,
# with basic setter and validation
###
class Bitmap
  attr_reader :width, :height

  def initialize(width, height)
    @width  = width
    @height = height
  end

  def to_s
    matrix.map do |row|
      row.join(' ')
    end.join("\n")
  end

  def valid?
    validate_width_and_height.nil?
  end

  def invalid_reason
    validate_width_and_height
  end

  def draw_pixel(x, y, value)
    matrix[y - 1][x - 1] = value
  end

  def reset
    @matrix = nil
  end

  private

  def matrix
    @matrix ||= Array.new(height) { Array.new(width) { 0 } }
  end

  def validate_width_and_height
    return if width.positive? && height.positive?

    "Width(#{width}) and Height(#{height}) has to be greater than ZERO"
  end
end
