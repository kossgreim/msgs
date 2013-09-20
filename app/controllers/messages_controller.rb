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
      
      respond_to do |format|
        if @message.save
          @conversation = Conversation.find(@message.conversation_id)
          format.html { redirect_to user_conversation_path(@conversation.id) }
          format.js  {@messages = @conversation.messages}
          format.json 
        else
          format.html 
          format.json { render json: @message.errors,
            status: :unprocessable_entity }
        end
      end
  end

  def update
  end

  def destroy
  end

  def message_params
    params.require(:message).permit(:user_id, :conversation_id, :body)
  end
end
