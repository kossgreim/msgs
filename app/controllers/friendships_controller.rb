class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(params[:friendship])
    if @friendship.save
      redirect_to root_url, :notice => "Successfully created friendship."
    else
      render :action => 'new'
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to root_url, :notice => "Successfully destroyed friendship."
  end
end
