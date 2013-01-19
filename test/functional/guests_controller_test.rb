require 'test_helper'

class GuestsControllerTest < ActionController::TestCase

  test "rsvp search" do
      post :search, {:rsvp_code => guests(:alan).rsvp_code}
      assert_redirected_to :action => :show, :rsvp_code => guests(:alan).rsvp_code
      assert_equal assigns(:guest), guests(:alan)
  end
end
