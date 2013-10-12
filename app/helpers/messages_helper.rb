module MessagesHelper

	def check_read_message(message)
		"unread_message" unless message.read?
	end

end
