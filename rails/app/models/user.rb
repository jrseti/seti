class User < ActiveRecord::Base
  has_many :assignments
  #def to_param
  #  [provider, uid].join('-')
  #end
  def friendly_name
    "<Friendly name>"
  end
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
    end
  end
end
