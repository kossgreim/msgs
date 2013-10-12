module ApplicationHelper

	def check_user_status(user_id, type=false)
		user = User.find(user_id)

		if user.last_request_at > 5.minutes.ago 
			type ? true : "Online"
		else
			type ? false : "Offline"
		end
	end

	def count_of_friends_requests
		current_user.friends_requests.count > 0 ? current_user.friends_requests.count : ""
	end

	def current_path_of_friends
		if count_of_friends_requests != "" and count_of_friends_requests > 0 
			friends_path(section: 'requests')
		else
			friends_path
		end
	end

	def count_of_friends(user_id)
		if params[:section] == 'online'
			Friendship.count_friends(user_id, 'online')
		else
			Friendship.count_friends(user_id)
		end
	end

end
