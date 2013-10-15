class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new(role: "guest") # guest user (not logged in)
    if user.role == "admin" 
        can :manage, :all
    elsif user.role == "user"
        can :manage, [UserConversation, User]
    elsif user.role == "guest"
        can :read, User
    end
    
  end
end
