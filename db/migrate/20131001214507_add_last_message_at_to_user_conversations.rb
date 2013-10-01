class AddLastMessageAtToUserConversations < ActiveRecord::Migration
  def change
    add_column :user_conversations, :last_message_at, :datetime
  end
end
