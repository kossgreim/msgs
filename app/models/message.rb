class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :conversations
	validates :body, presence: true
end

