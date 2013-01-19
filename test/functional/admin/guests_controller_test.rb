require 'test_helper'

class Admin::GuestsControllerTest < ActionController::TestCase
  # include Devise::TestHelpers

  setup do
    sign_out :refinery_user
  end
  
  test "all admin pages require login" do
    get :index
    assert_redirected_to "/refinery/login"
  end

  test "index with login" do
    sign_in :refinery_user, @user
    get :index
    assert_response :success
  end

end
