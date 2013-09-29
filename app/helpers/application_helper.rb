module ApplicationHelper

	def check_user_status(user_id)
		user = User.find(user_id)

		if user.last_request_at > 5.minutes.ago 
			return "Online"
		else
			return "Offline"
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

end
