# Generated by cucumber-sinatra. (2014-08-01 14:44:39 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/chitter.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = chiiter

class chiiterWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  chiiterWorld.new
end
