class Observation < ActiveRecord::Base
  belongs_to :target
  has_many :observation_ranges
end
