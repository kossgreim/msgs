class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :large => "500x500>", :little => "50x50#", :thumb => "100x100#", :profile => "300x300#" }, 
  			:default_url => "/images/:style/missing.png"

  validates :name, :user_name, presence: true
  validates :user_name, uniqueness: true

  #for friends 
  has_many :friendships, conditions: "confirmed = true"
  has_many :friends, through: :friendships
  has_many :freindships_requests, class_name: "Friendship", foreign_key: "user_id", conditions: "confirmed = false"
  has_many :freindships_requests, class_name: "Friendship", foreign_key: "friend_id", conditions: "confirmed = false"
  has_many :friends_requests, through: :freindships_requests, source: :user

  #for conversations
  has_many :user_conversations 
  has_many :conversations, through: :user_conversations
  has_many :messages, through: :conversations

  def self.search(search)
    if search
      where("name LIKE '%#{search}%'")
    else
      scoped
    end
  end

  
  
end
