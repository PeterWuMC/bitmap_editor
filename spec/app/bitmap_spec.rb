require 'bitmap'

describe Bitmap do

  let(:width)              { 5 }
  let(:height)             { 10 }
  let(:described_instance) { described_class.new(width, height) }

  describe '.new' do
    it 'initializes a 2D array with the given height and width, and default value is 0 (White)' do
      expect(described_instance.to_s).to eq """
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
""".strip
    end
  end

  describe '#set_pixel' do
    it 'update one pixel in the bitmap with a provided value' do
      described_instance.set_pixel(3, 2, 'C')

      expect(described_instance.to_s).to eq """
0 0 0 0 0
0 0 C 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
""".strip
    end
  end

  describe '#reset' do
    it 'resets the current bitmap to completely filled with 0 (White)' do
      described_instance.set_pixel(3, 2, 'X')

      expect{described_instance.reset}.to change {described_instance.to_s}.from("""
0 0 0 0 0
0 0 X 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
""".strip).to("""
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
0 0 0 0 0
""".strip)
    end
  end
end
