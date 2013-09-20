class MessagesController < ApplicationController

  def index 
      @conversation = UserConversation.find(params[:user_conversation_id])
      @messages = @conversation.messages
  end

  def new
      @conversation = UserConversation.find(params[:id])
      @conversation.build_message
  end

  def create
      @message = Message.new(message_params)
      @message.save!
      @conversation = UserConversation.where(conversation_id: @message.conversation_id)
      redirect_to :back
  end

  def update
  end

  def destroy
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end
