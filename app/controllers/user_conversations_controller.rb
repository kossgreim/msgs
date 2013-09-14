class UserConversationsController < ApplicationController
	def index 
		@user = User.find(current_user[:id])
		@conversations = @user.conversations
	end

	def show 
		@conversation = UserConversation.find(params[:id])
	end

	def new 
		@user = User.fund(current_user[:id])
		@conversation = @user.user_conversations.build
		@conversation.build_conversation.message.build
	end

	def create 
		@conversation = UserConversation.new(params[:user_conversation])
		@conversation.user = current_user
		@conversation.conversation.messages.frist.user = current_user 
		@conversation.save!

		redirect_to user_conversation_path(current_user, @conversation)
	end

end
