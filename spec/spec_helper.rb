# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  enable_coverage(:branch)
  add_filter('/spec/')
  add_filter('/vendor/')
  add_filter('/bin/')
  # add_group('Adapters', 'lib/adapter')
  # add_group('Builder', 'lib/builder')
  # add_group('Mapper', 'lib/mapper')
  track_files('lib/**/*.rb')
end

require 'pry'

Dir['./spec/custom/**/*.rb'].sort.each { |file| require file }
Dir['./spec/shared_examples/**/*.rb'].sort.each { |file| require file }
Dir['./spec/shared_contexts/**/*.rb'].sort.each { |file| require file }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.warnings = true
  config.disable_monkey_patching!
end
