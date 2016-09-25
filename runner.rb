# frozen_string_literal: true
require './app/bitmap_editor'
require './app/command'

@running       = true
@bitmap_editor = BitmapEditor.new

puts 'type ? for help'
while true
  print '> '
  result = Command.new(gets.chomp, @bitmap_editor).execute
  puts result == false ? 'command faild' : 'command successful'
end
