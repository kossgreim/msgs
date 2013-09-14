class UserConversation < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	has_many :messages, through: :conversations

	delegate :subject, to: :conversations
	delegate :users, to: :conversations
end
