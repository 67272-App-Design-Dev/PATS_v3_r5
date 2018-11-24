require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest"
require 'minitest/rails'
require 'minitest/reporters'
require 'minitest_extensions'
require 'contexts'


class ActiveSupport::TestCase
  # Since we are not using fixtures, comment this line out...
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  include Contexts

  # Add the infamous deny method...
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end

  # A set methods to login various types of users (for controller tests)
  def login_vet
    @vet = FactoryBot.create(:user, first_name: "Ted", username: "ted", role: "vet")
    get login_path
    post sessions_path, params: { username: "ted", password: "secret" }
  end
  
  def login_assistant
    @assistant = FactoryBot.create(:user, first_name: "Pa", username: "grape", role: "assistant")
    get login_path
    post sessions_path, params: { username: "grape", password: "secret" }
  end
  
  def login_owner
    @owner_user = FactoryBot.create(:user, first_name: "Ned", username: "ned", role: "owner")
    @logged_in_owner = FactoryBot.create(:owner, user: @owner_user, first_name: "Ned")
    get login_path
    post sessions_path, params: { username: "ned", password: "secret" }
  end

  # Spruce up minitest results...
  Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]
end
