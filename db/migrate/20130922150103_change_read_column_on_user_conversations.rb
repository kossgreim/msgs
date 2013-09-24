class ChangeReadColumnOnUserConversations < ActiveRecord::Migration
  def change
  	change_column :user_conversations, :read, :boolean, default: false
  end
end
