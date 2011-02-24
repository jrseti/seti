class Observation < ActiveRecord::Base
  belongs_to :target
  has_many :observation_ranges
  has_many :patterns
  def friendly_name
    target.name + " / " + date.to_s
  end
end
