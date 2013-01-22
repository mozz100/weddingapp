require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  test "new guest" do
    g = Guest.new
    assert !g.valid?
    assert !g.rsvp_code.blank?
    g.fname = "Richard"
    assert g.valid?
    g.save
    assert_equal 0, g.status
    g.rsvp_code = g.rsvp_code.downcase
    g.save
    assert_equal g.rsvp_code, g.rsvp_code.upcase
  end
end
