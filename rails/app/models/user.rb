class User < ActiveRecord::Base
  has_many :assignments
  def to_param
    facebook_id
  end
end
