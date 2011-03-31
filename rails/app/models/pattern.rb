# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

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
