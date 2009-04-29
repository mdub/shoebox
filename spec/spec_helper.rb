ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")

require 'spec'
require 'spec/rails'
require 'spec/rr'
require 'rr'

Spec::Runner.configure do |config|
  
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  config.mock_with RR::Adapters::Rspec

end

def image_fixture_file(name)
  Pathname("#{Rails.root}/spec/fixtures/images/#{name}")
end

def test_tmp_dir
  @test_tmp_dir ||= "#{Rails.root}/tmp/spec"
  FileUtils.mkpath(@test_tmp_dir)
  @test_tmp_dir
end
