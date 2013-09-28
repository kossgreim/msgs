class FriendshipsController < ApplicationController
  before_filter :authenticate_user! 
  
  def index 

    if params[:section] == 'requests'
      @requests = current_user.friends_requests
      render("requests", requests: @requests)
    end

    @user = current_user

    @real_friends = Friendship.where(user_id: current_user[:id], confirmed: true)

    @user_c = User.find(current_user)
    @friends = @user.friendships

    @conversation = @user_c.user_conversations.build
    @conversation.build_conversation.messages.build
  end

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to root_url, :notice => "Added friend."
    else
     redirect_to users_path, :notice => 'Unable to add friend'
    end
  end



  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to root_url, :notice => "Friend was removed"
  end

  def count_of_friends_requests
    current_user.friends_requests.count 
  end

  private 

  def friendship_params
    params.requare(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
