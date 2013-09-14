class FriendshipsController < ApplicationController
  before_filter :authenticate_user! 
  def index 
    @user = current_user
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

  private 

  def friendship_params
    params.requare(:friendship).permit(:user_id, :friend_id)
  end
end
