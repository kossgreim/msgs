class UserConversation < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	has_many :messages, through: :conversations

	accepts_nested_attributes_for :conversation

	delegate :subject, to: :conversations
	delegate :users, to: :conversations

	before_create :create_user_conversations

	private

	  def create_user_conversations
	   return if to.blank?

	   to.each do |recip|
	     UserConversation.create :user_id => recip, :conversation => conversation
	    end
	  end

end
