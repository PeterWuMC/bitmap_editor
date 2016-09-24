require_relative 'bitmap'

class BitmapEditor
  def new_bitmap(width, height)
    @bitmap = Bitmap.new(width.to_i, height.to_i)
  end

  def draw_vertical_line(x, starting_y, ending_y, value)
    return unless validate_pixels_out_of_range(x, x, starting_y, ending_y)

    (starting_y..ending_y).each do |y|
      draw_dot(x, y, value)
    end
  end

  def draw_horizontal_line(y, starting_x, ending_x, value)
    return unless validate_pixels_out_of_range(starting_x, ending_x, y, y)

    (starting_x..ending_x).each do |x|
      draw_dot(x, y, value)
    end
  end

  def draw_dot(x, y, value)
    bitmap.draw_pixel(x, y, value)
  end

  def display_bitmap
    puts bitmap.to_s
  end

  def terminate
    puts 'Good bye!'
    exit
  end

  private

  def bitmap
    if @bitmap.nil?
      puts 'Bitmap is not initialized'
      return false
    end
    @bitmap
  end

  def validate_pixels_out_of_range(starting_x, ending_x, starting_y, ending_y)
    if x_is_out_of_range?(starting_x, ending_x) || y_is_out_of_range?(starting_y, ending_y)
      puts "Specified X(#{starting_x}:#{ending_x}) and Y(#{starting_y}:#{ending_y}) is out " \
        "of the range of the bitmap (#{bitmap.width} x #{bitmap.height})"
      return false
    end
    true
  end

  def x_is_out_of_range?(starting_x, ending_x)
    [starting_x, ending_x].any? { |x| x <= 0 || x > bitmap.width }
  end

  def y_is_out_of_range?(starting_y, ending_y)
    [starting_y, ending_y].any? { |y| y <= 0 || y > bitmap.height }
  end

end
