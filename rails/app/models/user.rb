class User < ActiveRecord::Base
  has_many :assignments
  #def to_param
  #  [provider, uid].join('-')
  #end

  ROLES = {:user=>"User", :admin=>"Administrator", :explorer=>"Explorer"}
  
  # Note we're using "User" to mean basically someone who just registered.
  
  DEFAULT_ROLE = :user

  def initialize(params = nil)
    super
    self.role ||= DEFAULT_ROLE
  end

  def self.create_with_omniauth(auth, user_agent)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.email = auth["extra"]["user_hash"]["email"]  rescue "-"
      user.user_agent_at_creation = user_agent
    end
  end

  def friendly_role
    role ? ROLES[role.to_sym] : ""
  end
end
