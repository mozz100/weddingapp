class Guest < ActiveRecord::Base
  attr_accessible :fname, :lname, :rsvp_code
end
