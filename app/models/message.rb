class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversations
	validates :body, presence: true

	scope :unread_messages, ->(conversation_id, user_id) {where(conversation_id: conversation_id, read: false).where("user_id <> ?", user_id)}
end

