require 'test_helper'

class InitialPagesTest < ActionDispatch::IntegrationTest
  include ERB::Util

  config = Rails.application.config

  test "home page" do
    get "/"
    assert_response :success
    # <title> should be "Home - (whatever's configured)"
    assert_select "title", html_escape("#{config.home_page[:title]} - #{config.wedding_name}")

    get "/" + config.rsvp_page[:slug]
    assert_response :success
    assert_select "title", html_escape("#{config.rsvp_page[:title]} - #{config.wedding_name}")
  end

  test "rsvp form" do
    get "/" + config.rsvp_page[:slug]
    assert css_select("section#rsvp_form")
  end
end
