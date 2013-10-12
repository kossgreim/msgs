module FriendshipsHelper

	def get_text_of_empty_list
		if params[:section] == 'online' then "No online friends"
		else "No friends yet" end 
	end

end
