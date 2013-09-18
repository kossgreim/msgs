class UserConversation < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversation
	has_many :messages, through: :conversation
	attr_accessor :to
	accepts_nested_attributes_for :conversation, allow_destroy: true


	delegate :subject, to: :conversation
	delegate :users, to: :conversation

	after_create :create_user_conversations
	

	private

	  def create_user_conversations
	   #return if to.blank?
	  	
	   to.each do |recip|
	     UserConversation.create :user_id => recip, :conversation => conversation
	    end
	  end



end
