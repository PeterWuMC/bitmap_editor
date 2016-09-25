# frozen_string_literal: true
require 'bitmap'

describe Bitmap do
  let(:width)              { 3 }
  let(:height)             { 5 }
  let(:described_instance) { described_class.new(width, height) }

  describe '.new' do
    it 'initializes a 2D array with the given height and width, ' \
      ' and default value is 0 (White)' do
      expect(described_instance.to_s).to eq '
0 0 0
0 0 0
0 0 0
0 0 0
0 0 0
'.strip
    end
  end

  describe '#valid?' do
    let(:width)  { 10 }
    let(:height) { 10 }

    subject { described_class.new(width, height).valid? }

    %w(width height).each do |type|
      context "when the specified #{type} is" do
        context 'less than 0' do
          let(type.to_sym) { -1 }
          it { expect(subject).to be false }
        end

        context '0' do
          let(type.to_sym) { 0 }
          it { expect(subject).to be false }
        end

        context 'greater than 0' do
          let(type.to_sym) { 1 }
          it { expect(subject).to be true }
        end
      end
    end
  end

  describe '#invalid_reason' do
    context 'when the dimension provided was invalid' do
      error_message = 'Width(-1) and Height(1) has to be greater than ZERO'

      subject { described_class.new(-1, 1).invalid_reason }

      it "returns the error message #{error_message}" do
        expect(subject).to eq error_message
      end
    end
  end

  describe '#draw_pixel' do
    it 'update one pixel in the bitmap with a provided value' do
      described_instance.draw_pixel(1, 2, 'X')

      expect(described_instance.to_s).to eq '
0 0 0
X 0 0
0 0 0
0 0 0
0 0 0
'.strip
    end
  end
end
