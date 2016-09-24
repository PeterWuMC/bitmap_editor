require 'yaml'

module Command
  module_function

  COMMANDS_MAPPING = YAML.load_file(File.expand_path('../../config/commands.yml', __FILE__)).freeze

  def execute(command_string, bitmap_editor)
    command_string  = command_string.strip
    command_initial = command_string[0]
    command_mapping = COMMANDS_MAPPING[command_initial]

    if command_mapping.nil?
      puts "Unknown Command '#{command_initial}'"
      return false
    end

    command_regex = command_mapping['regex']
    arguments     = command_arguments(command_string, command_regex)

    if arguments.empty?
      puts "Not enough information to execute the command #{command_initial}: #{command_regex}"
      return false
    end
    bitmap_editor.send(command_mapping['method'], *arguments)
  end

  def command_arguments(command_string, command_regex)
    command_string.scan(command_regex).flatten
  end

  private_class_method :command_arguments
end
