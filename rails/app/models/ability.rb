class Ability
  include CanCan::Ability
  
  def initialize(user)
    if user.role.to_sym == :admin
      can :manage, :all
    else
      cannot :read, :all
    end
  end
end