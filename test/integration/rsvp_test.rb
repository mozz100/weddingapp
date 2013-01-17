require 'test_helper'

class InitialPagesTest < ActionDispatch::IntegrationTest
  include ERB::Util

  config = Rails.application.config

  test "rsvp form submit" do
    post_via_redirect "/guests/search", {:rsvp_code => guests(:alan).rsvp_code}
    assert_select "h3", "Hello, #{guests(:alan).fname}"
    
  end
end
