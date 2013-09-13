module UsersHelper

	def add_if_user_not_current(user, current_user)
		if user_signed_in?
			if user.id != current_user[:id]
				link_to "Add Friend", friendships_path(:friend_id => user), :method => :post 
			else
				link_to "edit profile", edit_user_registration_path
			end
		end
	end
end
