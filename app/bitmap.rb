class Bitmap
  attr_reader :matrix

  def initialize(width, height)
    @matrix = Array.new(height) { Array.new(width) {0} }
  end

  def to_s
    matrix.map do |row|
      row.join(' ')
    end.join("\n")
  end

  def set_pixel(x, y, value)
    matrix[y - 1][x - 1] = value
  end
end
