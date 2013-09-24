class AddBetweenToConversations < ActiveRecord::Migration
  def change
    add_column :conversations, :between, :text
  end
end
