class AddLastMessageAtToUserConversations < ActiveRecord::Migration
  def change
    add_column :user_conversations, :last_message_at, :datetime

    user_conversations = User_conversations.all
    user_conversations.each do |con|
    	con.update_attributes(last_message_at: con.conversation.mrssages.last.created_at)
    end
  end
end
