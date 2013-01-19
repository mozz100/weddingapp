require 'test_helper'

class InitialPagesTest < ActionDispatch::IntegrationTest
  include ERB::Util

  config = Rails.application.config

  test "home page" do
    get "/"
    assert_response :success
    # <title> should be "Home - (whatever's configured)"
    assert_select "title", html_escape("#{I18n.t('home.title')} - #{config.wedding_name}")
  end

  test "rsvp form" do
    get "/rsvp"
    assert_response :success
    assert_select "title", html_escape("#{I18n.t('rsvp.title')} - #{config.wedding_name}")
    assert css_select("section#rsvp_form")
  end
end
