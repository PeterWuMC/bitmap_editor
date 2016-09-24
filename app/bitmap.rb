class Bitmap
  attr_reader :matrix, :width, :height

  def initialize(width, height)
    @width  = width
    @height = height
    reset
  end

  def to_s
    matrix.map do |row|
      row.join(' ')
    end.join("\n")
  end

  def set_pixel(x, y, value)
    matrix[y - 1][x - 1] = value
  end

  def reset
    @matrix = Array.new(height) { Array.new(width) {0} }
  end
end
