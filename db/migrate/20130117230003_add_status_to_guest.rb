class AddStatusToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :status, :integer, :default => 0
  end
end
