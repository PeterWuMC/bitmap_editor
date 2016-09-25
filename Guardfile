# frozen_string_literal: true
guard :rspec, cmd: 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.+)\.rb$})     { |m| "spec/app/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { 'spec' }
end
