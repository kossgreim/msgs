class UserConversationsController < ApplicationController
	before_action :set_conversation, only: [:show, :edit, :update, :destroy]

	def index 
		@user = User.find(current_user)
		@conversations = @user.user_conversations
	end

	def show 
		@conversation = UserConversation.find(params[:id])
		@message = Message.new(conversation_id: @conversation.conversation_id, user_id: current_user[:id])
	end

	def new 
		@user = User.find(current_user)
		@friends = @user.friendships

		@conversation = @user.user_conversations.build
		@conversation.build_conversation.messages.build

		#raise YAML::dump(@conversation.conversation)
	end

	def create 
		@conversation = UserConversation.new(user_conversation_params)
		@conversation.user = current_user
	
		@conversation.conversation.messages.first.user = current_user
		
		@conversation.save!

		redirect_to user_conversation_path(@conversation)
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

	def set_conversation
		@conversation = UserConversation.find(params[:id])
	end

	def user_conversation_params
		params.require(:user_conversation).permit(:to, :deleted, :user_id, :conversation_id, :read, 
			conversation_attributes: [:id, :subject, messages_attributes: [:id, :body, :user_id, :conversation_id]])
	end

end
