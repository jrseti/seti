# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class Observation < ActiveRecord::Base
  belongs_to :target
  has_many :observation_ranges
  has_many :patterns
  def friendly_name
    target.name + " / " + date.to_s
  end
end
