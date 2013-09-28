module ApplicationHelper

	def check_user_status(user_id)
		user = User.find(user_id)

		if user.last_request_at > 5.minutes.ago 
			return "Online"
		else
			return "Offline"
		end
	end

end
