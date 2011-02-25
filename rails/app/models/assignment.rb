class Assignment < ActiveRecord::Base
  belongs_to :observation_range
  belongs_to :user
  def friendly_name
    observation_range.friendly_name + " / " + user.name
  end
end
