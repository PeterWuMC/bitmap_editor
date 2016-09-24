require 'bitmap_editor'

describe BitmapEditor do
  let(:width)              { 3 }
  let(:height)             { 5 }
  let(:described_instance) { described_class.new(width, height) }
  let(:bitmap)             { described_instance.send(:bitmap) }

  describe '#draw_vertical_line' do
    let(:x)          { 2 }
    let(:starting_y) { 2 }
    let(:ending_y)   { height }
    subject { described_instance.draw_vertical_line(x, starting_y, ending_y, 'X') }

    context 'when the any of the specified pixel is out of range of the bitmap' do
      let(:ending_y) { height + 1 }

      it "prints the error message" do
        expect { subject }.to output("Specified X(2:2) and Y(2:6) is out of the range of the bitmap (3 x 5)\n").to_stdout
      end
    end

    context 'when all the specified pixels are inside the range of the bitmap' do
      it 'update bitmap with a vertical line with the provided value' do
        expect{ subject }.to change { bitmap.to_s }.to """
0 0 0
0 X 0
0 X 0
0 X 0
0 X 0
  """.strip
      end
    end
  end

  describe '#draw_horizontal_line' do
    let(:starting_x) { 1 }
    let(:ending_x)   { width }
    let(:y)          { 4 }
    subject { described_instance.draw_horizontal_line(y, starting_x, ending_x, 'X') }

    context 'when the any of the specified pixel is out of range of the bitmap' do
      let(:ending_x) { width + 1 }

      it "prints the error message" do
        expect { subject }.to output("Specified X(1:4) and Y(4:4) is out of the range of the bitmap (3 x 5)\n").to_stdout
      end
    end

    context 'when all the specified pixels are inside the range of the bitmap' do
      it 'update the bitmap with a horizontal line with the provided value' do
        expect{ subject }.to change { bitmap.to_s }.to """
0 0 0
0 0 0
0 0 0
X X X
0 0 0
  """.strip
      end
    end
  end
end
