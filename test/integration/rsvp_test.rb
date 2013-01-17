require 'test_helper'

class RsvpTest < ActionDispatch::IntegrationTest
  include ERB::Util

  config = Rails.application.config

  test "rsvp form submit" do
    # POST upper and lower case versions of rsvp code, ensure both match
    [:downcase, :upcase].each do |m|
      post_via_redirect "/guests/search", {:rsvp_code => guests(:alan).rsvp_code.send(m)}
      assert_select "h3", "Hello, #{guests(:alan).fname}"
    end

    # POST an incorrect code
    code = "HJKL1"
    assert_not_equal code, guests(:alan).rsvp_code
    post_via_redirect "/guests/search", {:rsvp_code => code}, {"HTTP_REFERER" => "/" + config.rsvp_page[:slug]}

    # assert not on guest page
    assert_equal 0, css_select("h3").length

    # assert error message is flashed
    assert_select "div#flash_error", html_escape(I18n.t("guests.fail_match_rsvp_code"))

    # assert code retained as entered, for user to check and correct
    assert_equal 1, css_select("input#rsvp_code[value='"+code+"']").length
  end
end
