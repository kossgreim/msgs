module UsersHelper

	def add_control_links(user, current_user)
		
		if user_signed_in?
			if user.id != current_user[:id]
				if Friendship.exists? friend_id: user.id
					link_to "Remove friend", friends_path, :method => :delete, class: "users-control-link"
				else
					link_to "Add Friend", friendships_path(:friend_id => user), :method => :post, class: "users-control-link" 
				end
			else
				link_to "Edit profile", edit_user_registration_path, class: "users-control-link"
			end
		end

	end
	
end
