class Assignment < ActiveRecord::Base
  belongs_to :observation_range
  belongs_to :user
  has_many :pattern_marks
  def friendly_name    
    observation_range.friendly_name + " / " + user.name rescue "-"
  end
end
