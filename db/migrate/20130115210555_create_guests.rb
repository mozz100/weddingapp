class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :rsvp_code
      t.string :fname
      t.string :lname

      t.timestamps
    end
  end
end
