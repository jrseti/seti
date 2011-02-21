class User < ActiveRecord::Base
  has_many :assignments
  def to_param
    facebook_id
  end
  def friendly_name
    first_name + " " + last_name + " / " + facebook_id
  end
end
