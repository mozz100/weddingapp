require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test "new guest" do
    g = Guest.new :fname => "Richard"
    assert !g.valid?
    assert !g.rsvp_code.blank?
    g.lname = "Morrison"
    assert g.valid?
  end
end
