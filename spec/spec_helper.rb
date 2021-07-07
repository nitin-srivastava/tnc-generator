require 'rspec'
require 'simplecov'
SimpleCov.start
RSpec.configure do |config|
  config.before(:suite) do
    ENV["RUBY_ENV"] = 'test'
  end

  config.after(:suite) do
    ENV["RUBY_ENV"] = 'development'
  end
end
