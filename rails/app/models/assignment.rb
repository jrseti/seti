class Assignment < ActiveRecord::Base
  belongs_to :observation_range
  belongs_to :user
end
