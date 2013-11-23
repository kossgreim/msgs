class UserConversation < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	has_many :messages, through: :conversation
	attr_accessor :to
	accepts_nested_attributes_for :conversation, allow_destroy: true


	delegate :subject, to: :conversation
	delegate :users, to: :conversation

	#before_create :create_user_conversations
	
	#def check_messages(user_id)
	#	messages = Message.unread_messages(self.id, user_id)
	#	self.update_attributes read: true unless self.read?
	#	messages.each {|m| m.update_attributes read: true unless m.read?}
	#end

	private

	  def create_user_conversations
	   #return if to.blank?
	  	
	   for recip in to
	     UserConversation.create :user_id => recip, :conversation => conversation
	    end
	  end



end
