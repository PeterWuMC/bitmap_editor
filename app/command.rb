# frozen_string_literal: true
require 'yaml'

###
# This class responsible for parsing the command string and
# call the associated functions in BitmapEditor using the
# mapping in config/commands.yml
###
class Command
  COMMANDS_MAPPING = YAML.load_file(
    File.expand_path('../../config/commands.yml', __FILE__)
  ).freeze

  attr_reader :command_string, :bitmap_editor,
              :command_initial, :command_mapping

  def initialize(command_string, bitmap_editor)
    @command_string  = command_string.strip
    @bitmap_editor   = bitmap_editor
    @command_initial = command_string[0]
    @command_mapping = COMMANDS_MAPPING[command_initial]
  end

  def execute
    return print_help if help_command?
    unless command_present?
      print_unknow_command
      return false
    end

    unless matches_regex?
      print_wrong_arguments
      return false
    end
    bitmap_editor.send(*send_command)
  end

  private

  def help_command?
    command_initial == '?'
  end

  def print_help
    COMMANDS_MAPPING.each do |_, command_info|
      puts command_info['description']
    end
  end

  def print_unknow_command
    puts "Unknown Command '#{command_initial}'"
  end

  def print_wrong_arguments
    puts 'Not enough information to execute the command ' \
      "#{command_initial}: #{command_regex}"
  end

  def command_present?
    !command_mapping.nil?
  end

  def command_regex
    command_mapping['regex']
  end

  def command_method
    command_mapping['method']
  end

  def send_command
    [command_method] + command_arguments
  end

  def matches_regex?
    !(command_string =~ command_regex).nil?
  end

  def command_arguments
    matches = command_string.scan(command_regex)
    matches.first.is_a?(Array) ? matches.flatten : []
  end
end
