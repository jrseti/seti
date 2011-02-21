class User < ActiveRecord::Base
  def to_param
    facebook_id
  end
end
