class Ability
  include CanCan::Ability
  
  def initialize(user)
    role = user.role.to_sym
    if role == :admin
      can :manage, :all
      can :explore, :all
    elsif role == :explorer
      can :explore, :all
    else
      cannot :read, :all
    end
  end
end