require 'test_helper'

class InitialPagesTest < ActionDispatch::IntegrationTest
  include ERB::Util
  test "home page" do
    get "/"
    assert_response :success
    # <title> should be "Home - (whatever's configured)"
    assert_select "title", html_escape("#{Refinery::Page.find_by_link_url("/").title} - #{Rails.application.config.wedding_name}")
  end
end
