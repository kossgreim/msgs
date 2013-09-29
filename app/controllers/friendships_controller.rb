class FriendshipsController < ApplicationController
  before_filter :authenticate_user! 
  
  def index 
    @user = current_user

    if params[:section] == 'requests'
      @requests = current_user.friends_requests
      render("requests", requests: @requests)
    end

    @friends = @user.friendships

    @conversation = @user.user_conversations.build
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

  def accept_friend_request
      @current_request = Friendship.where(user_id: params[:request_user_id], friend_id: current_user[:id])
      @current_request.first.update_attributes confirmed: true
      
      @new_friendship = Friendship.new(user_id: current_user[:id], friend_id: params[:request_user_id], confirmed: true)
      if @new_friendship.save
        redirect_to friends_path, notice: "Friends request accepted"
      else
        redirect_to friends_path, notice: "Friends request was'nt accepted"
      end
  end

  def delete_friend_request
      @current_request = Friendship.find_by_user_id_and_friend_id(params[:request_user_id], current_user[:id])
      @current_request.destroy
      redirect_to friends_path, notice: "Request deleted"
  end


  def destroy
    @friendship_current = current_user.friendships.find(params[:id])
    @friendship_friend = Friendship.find_by_user_id_and_friend_id(@friendship_current.friend_id, current_user[:id])
    @friendship_current.destroy
    @friendship_friend.destroy
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
