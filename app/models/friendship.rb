class Friendship < ActiveRecord::Base
 	belongs_to :user
 	belongs_to :friend, class_name: "User"
 	belongs_to :friend_inverse, class_name: "User", foreign_key: "friend_id"

 	def self.count_friends(user_id, type='all')
 		user = User.find(user_id) || not_found
 		if type == 'online'
	 		user.friends.each do |friend|
	 			online_friends = []
	 			online_friends << friend if friend.last_request_at > 5.minutes.ago 
	 			return online_friends.count
	 		end
 		else
 			user.friends.count
 		end
 	end
end
