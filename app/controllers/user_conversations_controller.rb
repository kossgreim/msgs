class UserConversationsController < ApplicationController
	before_filter :authenticate_user!
	before_action :set_conversation, only: [:show, :edit, :update, :destroy]

	def index 
		@user = User.find(current_user)
		@conversations = @user.user_conversations.order('last_message_at DESC')
	end

	def show 
		@conversation = UserConversation.find(params[:id]) 
		check_messages(@conversation)
		@message = Message.new(conversation_id: @conversation.conversation_id, user_id: current_user[:id])
		redirect_to user_conversation_path if @conversation.deleted?
		
		respond_to do |format|
			format.html
			format.js 
		end
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
		@conversation.conversation.between = @conversation.to.dup
		@conversation.conversation.between << current_user[:id]
		@conversation.save!
		
		if !@conversation.to.blank?
			@conversation.to.each { |t| UserConversation.create user_id: t, conversation: @conversation.conversation }
		end

		redirect_to user_conversation_path(@conversation)
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
		messages = Message.where(conversation_id: conversation.conversation_id).where("user_id <> ?", current_user[:id]).where(read: false)
		conversation.update_attributes read: true unless conversation.read?
		
		messages.each {|m| m.update_attributes read: true unless m.read?}
	end

	#if exsist some conversation between current users, then method returns this conversations id
	def check_conversation(between_users)
		@current_user_conversations = UserConversation.select(:conversation_id).where(user_id: current_user[:id])
		@current_user_conversations.each do |con|	
			return con.id if con.between.sort == between_users.sort
		end
		return false
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
