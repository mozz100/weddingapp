class AddDataToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :stored_data, :text
  end
end
