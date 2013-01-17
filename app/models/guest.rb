class Guest < ActiveRecord::Base
  attr_accessible :fname, :lname, :rsvp_code
  validates :fname, :lname, :rsvp_code, :presence => true
  validates :rsvp_code, :presence => true

  before_validation :ensure_rsvp_code

  protected

  def ensure_rsvp_code
    # letters and numbers that are easily pronounceable and unlikely to get mixed up.
    # No m/n 0/O confusion.
    if rsvp_code.blank?
        possibilities = ["B","C","D","F","G","H","K","L","P","Q","R","T","W","X","Y","2","3","4","6","7","8","9"]
        code_length = 6
        self.rsvp_code = (0...code_length).map{ possibilities[rand(possibilities.length)] }.join
    end
    self.rsvp_code = self.rsvp_code.upcase
  end
end
