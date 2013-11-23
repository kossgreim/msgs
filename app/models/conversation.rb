class Conversation < ActiveRecord::Base
	has_many :user_conversations, dependent: :destroy
	has_many :users, through: :user_conversations
	has_many :messages, dependent: :destroy

	serialize :between

	accepts_nested_attributes_for :messages, allow_destroy: true

end
