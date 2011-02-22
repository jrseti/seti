class User < ActiveRecord::Base
  has_many :assignments
  #def to_param
  #  [provider, uid].join('-')
  #end

  ROLES = {:user=>"User", :admin=>"Administrator", :explorer=>"Explorer"}
  
  DEFAULT_ROLE = :user

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["user_info"]["name"]
      user.role = DEFAULT_ROLE
    end
  end

  def friendly_role
    ROLES[role.to_sym]
  end
end
