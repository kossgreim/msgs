class Conversation < ActiveRecord::Base
	has_many :user_conversations 
	has_many :users, through: :user_conversations
	has_many :messages

end
