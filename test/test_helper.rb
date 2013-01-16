ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # called before every single test
  def setup
    load "#{Rails.root}/db/seeds.rb"
    if Refinery::User.count < 1
      
      # create Refinery role
      rr = Refinery::Role.new
      rr.title = "Refinery"
      rr.save

      # create Superuser role
      su = Refinery::Role.new
      su.title = "Superuser"
      su.save

      # create Refinery user and give both roles
      @user = Refinery::User.create({
        :email => "test@example.com",
        :username => "tester",
        :password => "asdf",
        :password_confirmation => "asdf"
      })
      @user.roles << rr
      @user.roles << su
      @user.save
    end
  end

  # Add more helper methods to be used by all tests here...
end
