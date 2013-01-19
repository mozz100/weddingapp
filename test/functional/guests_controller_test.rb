require 'test_helper'

class GuestsControllerTest < ActionController::TestCase

  test "rsvp search" do
      post :search, {:rsvp_code => guests(:alan).rsvp_code}
      assert_redirected_to :action => :show, :rsvp_code => guests(:alan).rsvp_code
      assert_equal assigns(:guest), guests(:alan)
  end

  test "rsvp coming" do
    post :update, {:rsvp_code => guests(:alan).rsvp_code, :guest => {:status => +1}}
    assert_redirected_to "/"
    assert_equal I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.see_you_there")), flash[:success]
  end

  test "rsvp not coming" do
    post :update, {:rsvp_code => guests(:alan).rsvp_code, :guest => {:status => -1}}
    assert_redirected_to "/"
    assert_equal I18n.t("guests.rsvp_succeeded", :msg => I18n.t("guests.sorry_not_coming")), flash[:success]
  end

  test "rsvp no response" do
    post :update, {:rsvp_code => guests(:alan).rsvp_code}
    assert_redirected_to :action => :show, :rsvp_code => guests(:alan).rsvp_code
    assert_equal I18n.t("guests.rsvp_error"), flash[:error]
  end
end
