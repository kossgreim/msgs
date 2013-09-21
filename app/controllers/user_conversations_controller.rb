class UserConversationsController < ApplicationController
	before_action :set_conversation, only: [:show, :edit, :update, :destroy]

	def index 
		@user = User.find(current_user)
		@conversations = @user.user_conversations
	end

	def show 
		@conversation = UserConversation.find(params[:id])
		check_messages(@conversation)
		@message = Message.new(conversation_id: @conversation.conversation_id, user_id: current_user[:id])

		if @conversation.deleted?
			redirect_to user_conversation_path
		end
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
		
		if !@conversation.to.blank?
			@conversation.to.each do |t|
				UserConversation.create :user_id => t, :conversation => @conversation.conversation
			end
		end

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

	def destroy
		@conversation = UserConversation.find(params[:id])
		@conversation.update_attributes deleted: true

		@conversations = User.find(current_user).user_conversations

		respond_to do |format|
			format.js {@conversations}
		end
	end

	def check_messages(conversation)
		messages = Message.where(conversation_id: conversation.conversation_id).where("user_id <> ?", current_user[:id])

		messages.each do |m|
			if !m.read?
				m.update_attributes read: true
			end
		end
	end

	private 

	def set_conversation
		@conversation = UserConversation.find(params[:id])
	end

	def user_conversation_params
		params.require(:user_conversation).permit(:deleted, :user_id, :conversation_id, :read, to: [],
			conversation_attributes: [:id, :subject, messages_attributes: [:id, :body, :user_id, :conversation_id]])
	end

end
