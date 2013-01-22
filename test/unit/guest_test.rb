# coding: utf-8
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

  test "get name from line" do
    assert_equal ["Bob", "Smith"], Guest.name_from_line("Bob Smith")
    assert_equal ["Bob", "Smith"], Guest.name_from_line(" Bob Smith")
    assert_equal ["Bob", "Smith"], Guest.name_from_line(" Bob  Smith")
    assert_equal ["Bob", "Smith"], Guest.name_from_line(" Bob  Smith  ")
    assert_equal ["Bob", "Smith"], Guest.name_from_line(" Bob \t Smith  ")

    assert_equal ["Bob", "Goodman Smith"], Guest.name_from_line(" Bob Goodman  Smith  ")

    assert_equal ["Bob", nil],     Guest.name_from_line("    Bob  ")
    assert_equal ["Åse", "Riise"], Guest.name_from_line(" Åse Riise")

  end
end
