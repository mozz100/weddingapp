require 'test_helper'

class RsvpTest < ActionDispatch::IntegrationTest
  include ERB::Util

  config = Rails.application.config

  test "rsvp form submit" do
    # POST upper and lower case versions of rsvp code, ensure both match
    [:downcase, :upcase].each do |m|
      post_via_redirect "/guests/search", {:rsvp_code => guests(:alan).rsvp_code.send(m)}
      assert_select "h3", "Hello, Alan"
    end

    # POST an incorrect code
    code = "HJKL1"
    assert_not_equal code, guests(:alan).rsvp_code
    post_via_redirect "/guests/search", {:rsvp_code => code}, {"HTTP_REFERER" => "/rsvp"}

    # assert not on guest page
    assert_equal 0, css_select("h3").length

    # assert error message is flashed
    assert_select "div#flash_error", html_escape(I18n.t("guests.fail_match_rsvp_code"))

    # assert code retained as entered, for user to check and correct
    assert_equal 1, css_select("input#rsvp_code[value='"+code+"']").length
  end

  test "positive rsvp" do
    post_via_redirect "/guests/search", {:rsvp_code => guests(:alan).rsvp_code}
    assert_select "h3", "Hello, Alan"

    # Alan forgets to answer custom questions
    put_via_redirect "/guests/#{guests(:alan).rsvp_code}", {
      :guest => {:status => 1},
      :data => {}
    }
    assert_select "h3", "Hello, Alan"
    assert_match  'flash_error', @response.body

    # choose food this time
    data_to_post = {}
    Wedding::Application.config.custom_questions.each do |q|
      data_to_post[q[:key]] = "some data"
    end
    put_via_redirect "/guests/#{guests(:alan).rsvp_code}", {
      :guest => {:status => 1},
      :data => data_to_post
    }, {"HTTP_REFERER" => "/rsvp"}

    assert_match 'flash_success', @response.body

  end

   test "negative rsvp" do
    post_via_redirect "/guests/search", {:rsvp_code => guests(:alan).rsvp_code}
    assert_select "h3", "Hello, Alan"

    data_to_post = {}
    put_via_redirect "/guests/#{guests(:alan).rsvp_code}", {
      :guest => {:status => -1},
      :data => data_to_post
    }, {"HTTP_REFERER" => "/rsvp"}

    assert_match 'flash_success', @response.body

  end
end
