class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :deleted
      t.boolean :read
      t.datetime :last_message_at
      t.timestamps
    end
  end
end
