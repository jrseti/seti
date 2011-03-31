# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class ObservationRange < ActiveRecord::Base
  belongs_to :observation
  has_many :assignments
  def friendly_name
    observation.friendly_name + " / " + lo_mhz.to_s + "-" + hi_mhz.to_s
  end
end
