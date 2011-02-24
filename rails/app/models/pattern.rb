class Pattern < ActiveRecord::Base
  belongs_to :observation
  has_many :pattern_marks
  def friendly_name
    "#{observation.friendly_name} / #{(hi_mhz + lo_mhz) / 2}"
  end
end
