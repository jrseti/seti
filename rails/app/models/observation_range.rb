class ObservationRange < ActiveRecord::Base
  belongs_to :observation
  has_many :assignments
  def friendly_name
    observation.friendly_name + " / " + lo_mhz.to_s + "-" + hi_mhz.to_s
  end
end
