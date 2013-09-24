module MessagesHelper

	def check_read_message(message)
		if message.read == false
			return "unread_message"
		end
	end

end
