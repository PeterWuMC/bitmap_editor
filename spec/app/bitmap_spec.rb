require 'bitmap'

describe Bitmap do

  let(:width)              { 5 }
  let(:height)             { 10 }
  let(:described_instance) { described_class.new(width, height) }

  subject { described_instance.to_s }

  describe '.new' do
    it 'initializes a 2D array with the given height and width, and default value is 0 (White)' do
      expect(subject).to eq """
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
end
