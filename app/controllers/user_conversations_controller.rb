class UserConversationsController < ApplicationController
	def index 
		@user = User.find(current_user)
		@conversations = @user.conversations
	end

	def show 
		@conversation = UserConversation.find(params[:id])
	end

	def new 
		@user = User.find(current_user)
		@friends = @user.friendships
		@conversation = @user.user_conversations.build
		@conversation.build_conversation.messages.build
	end

	def create 
		@conversation = UserConversation.new(user_conversation_params)
		@conversation.user = current_user
		
		@conversation.conversation.messages.first.user = current_user
		@conversation.save!

		redirect_to user_conversation_path(current_user, @conversation)
	end

	def mark_as_read
		@conversation = UserConversation.find(params[:id])
		@conversation.update_attributes read: true

		redirect_to user_conversation_path(current_user, @conversation)
	end

	def mark_us_unread
		@conversation = UserConversation.find(params[:id])
		@conversation.update_attributes read: false

		redirect_to user_conversation_path(current_user, @conversation)
	end

	private 

	def user_conversation_params
		params.require(:user_conversation).permit(:to, :deleted, :user_id, :conversation_id, :read, conversation: [:subject], message: [:body, :user_id])
	end

end
