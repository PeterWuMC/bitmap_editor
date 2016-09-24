require 'command'
require 'bitmap_editor'

describe Command do

  before { stub_const("#{described_class}::COMMANDS_MAPPING", dummy_commands_mapping) }

  describe '.execute' do
    let(:bitmap_editor) { BitmapEditor.new }
    let(:method)        { :new_bitmap }
    let(:regex)         { /^[a-zA-Z]\s([0-9]+)\s([0-9]+)$/ }
    let(:dummy_commands_mapping) do
      {
        'I' => {
          'regex'  => regex,
          'method' => method
        }
      }
    end

    subject { described_class.execute(command_string, bitmap_editor) }

    shared_examples :arguments_incorrect_error do
      it 'does not call the method in bitmap' do
        expect(bitmap_editor).not_to receive(method)
        ignore_stdout { subject }
      end

      it 'prints the error message' do
        expect { subject }.to output("Not enough information to execute the command I: (?-mix:^[a-zA-Z]\\s([0-9]+)\\s([0-9]+)$)\n").to_stdout
      end
    end

    context 'when the command is not found' do
        let(:command_string) { 'Z' }

      it 'prints the error message' do
        expect { subject }.to output("Unknown Command 'Z'\n").to_stdout
      end
    end

    context 'when the command is found' do
      context 'and the arguments are provided correctly' do
        let(:command_string) { 'I 10 10' }

        it 'calls the method in bitmap with the matching regex' do
          expect(bitmap_editor).to receive(method).with('10', '10')
          subject
        end
      end

      context 'and the arguments are not provided in correctly format' do
        let(:command_string) { 'I A 10' }

        it_behaves_like :arguments_incorrect_error
      end

      context 'and there are missing arguments' do
        let(:command_string) { 'I 10' }
        it_behaves_like :arguments_incorrect_error
      end
    end
  end
end
