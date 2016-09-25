# frozen_string_literal: true
$LOAD_PATH.unshift(File.expand_path('../../app', __FILE__))
require 'rspec'

def ignore_stdout
  string_io = StringIO.new
  old_stdout = $stdout
  $stdout = string_io
  yield if block_given?
  $stdout = old_stdout
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
