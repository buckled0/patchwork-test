ENV["RAILS_ENV"] ||= "test"

# This file is copied to spec/ when you run "rails generate rspec:install"
require File.expand_path("../config/environment", __dir__)

require "rspec/rails"
require "webmock/rspec"

require "vcr"
VCR.configure do |c|
  c.cassette_library_dir = "spec/vcr"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  vcr_mode = :once
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = true
  config.infer_spec_type_from_file_location!

  config.include Rails.application.routes.url_helpers

  config.order = :random
  Kernel.srand config.seed

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end
