require 'bitmap_editor'

describe BitmapEditor do
  let(:width)              { 3 }
  let(:height)             { 5 }
  let(:described_instance) { described_class.new }
  let(:bitmap)             { described_instance.send(:bitmap) }

  before { described_instance.new_bitmap(width, height) }

  shared_examples :bitmap_not_initialize do
    context 'when bitmap is not initialised' do
      before { described_instance.instance_variable_set('@bitmap', nil) }

      it "prints the error message" do
        expect { subject }.to output("Bitmap is not initialized\n").to_stdout
      end

      it { ignore_stdout { expect(subject).to be false } }
    end
  end

  describe '#draw_dot' do
    let(:x) { 2 }
    let(:y) { 2 }
    subject { described_instance.draw_dot(x, y, 'X') }

    it_behaves_like :bitmap_not_initialize

    context 'when the any of the specified pixel is out of range of the bitmap' do
      let(:y) { height + 1 }

      it "prints the error message" do
        expect { subject }.to output("Specified X(2:2) and Y(6:6) is out of the range of the bitmap (3 x 5)\n").to_stdout
      end

      it { ignore_stdout { expect(subject).to be false } }
    end

    context 'when all the specified pixels are inside the range of the bitmap' do
      it 'update bitmap with a vertical line with the provided value' do
        expect{ subject }.to change { bitmap.to_s }.to """
0 0 0
0 X 0
0 0 0
0 0 0
0 0 0
  """.strip
      end
    end
  end

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

      it { ignore_stdout{ expect(subject).to be false } }
    end

    context 'when all the specified pixels are inside the range of the bitmap' do
      it 'update bitmap with a vertical line with the provided value' do
        expect { subject }.to change { bitmap.to_s }.to """
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

      it { ignore_stdout { expect(subject).to be false } }
    end

    context 'when all the specified pixels are inside the range of the bitmap' do
      it 'update the bitmap with a horizontal line with the provided value' do
        expect { subject }.to change { bitmap.to_s }.to """
0 0 0
0 0 0
0 0 0
X X X
0 0 0
  """.strip
      end
    end
  end

  describe '#display_bitmap' do
    subject { described_instance.display_bitmap }

    it_behaves_like :bitmap_not_initialize

    context 'when bitmap is initialised' do
      it 'prints the bitmap to stdout' do
        expect { subject }.to output("0 0 0\n0 0 0\n0 0 0\n0 0 0\n0 0 0\n").to_stdout
      end
    end
  end

  describe '#terminate' do
    subject { described_instance.terminate }
    before { allow(described_instance).to receive(:exit) }

    it 'prints Good bye!' do
      expect { subject }.to output("Good bye!\n").to_stdout
    end

    it 'exit application' do
      expect(described_instance).to receive(:exit)
      ignore_stdout { subject }
    end
  end
end
