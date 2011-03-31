# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new
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