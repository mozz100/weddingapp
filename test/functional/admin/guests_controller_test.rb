require 'test_helper'

class Admin::GuestsControllerTest < ActionController::TestCase
  # include Devise::TestHelpers

  setup do
    sign_out :refinery_user
    @alan = guests(:alan)
  end
  
  test "all admin pages require login" do
    get :index
    assert_redirected_to "/refinery/login"
    put :update, :id => @alan.id
    assert_redirected_to "/refinery/login"
  end

  test "index with login" do
    sign_in :refinery_user, @user
    get :index
    assert_response :success
  end

  test "update a guest" do
    sign_in :refinery_user, @user
    post :update, {:id => @alan.id, :guest => {:fname => "Charles", :lname => "Chaplain"}}
    assert_redirected_to admin_guests_path
    @alan.reload
    assert_equal "Charles", @alan.fname

  end

end
