# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class Assignment < ActiveRecord::Base
  belongs_to :observation_range
  belongs_to :user
  has_many :pattern_marks
  def friendly_name    
    observation_range.friendly_name + " / " + user.name rescue "-"
  end
end
