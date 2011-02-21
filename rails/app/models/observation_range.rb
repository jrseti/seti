class ObservationRange < ActiveRecord::Base
  belongs_to :observation
  has_many :assignments
end
