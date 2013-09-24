module UserConversationsHelper

	def check_read_status(conversation)
		if conversation.read != nil and  conversation.read == false
			return "unread"
		end
	end
end
