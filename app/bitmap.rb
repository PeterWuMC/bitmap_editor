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

  private

  def matrix
    @matrix ||= Array.new(height) { Array.new(width) {0} }
  end

  def validate_width_and_height
    return "Width(#{width}) and Height(#{height}) has to be greater than ZERO" unless width > 0 && height > 0
  end
end
