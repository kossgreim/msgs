class AddConfirmedToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :confirmed, :boolean, default: false
  end
end
