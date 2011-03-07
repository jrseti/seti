class Pattern < ActiveRecord::Base
  belongs_to :observation
  has_many :pattern_marks
  def average_mhz
    (hi_mhz + lo_mhz) / 2.0
  end
  def friendly_name
    "#{observation.friendly_name} / #{average_mhz}"
  end
  
end
