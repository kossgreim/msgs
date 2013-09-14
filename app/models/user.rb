class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, :styles => { :large => "500x500>", :thumb => "100x100#", :profile => "300x300#" }, 
  			:default_url => "/images/:style/missing.png"

  validates :name, :user_name, presence: true
  validates :user_name, uniqueness: true

  #for friends 
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  #for conversations
  has_many :user_conversations 
  has_many :conversations, through: :user_conversations
  has_many :messages, through: :conversations

  
  
end
