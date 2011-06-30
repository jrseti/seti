# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#
require "csv"

class Assignment < ActiveRecord::Base
  belongs_to :observation_range
  belongs_to :user
  has_many :pattern_marks
  def self.csv_header
    %w{assignment_id target observation_date observation_range_lo observation_range_hi user_id assigned_date}.to_csv
  end
  
  def friendly_name    
    observation_range.friendly_name + " / " + user.name rescue "-"
  end
  
  def to_csv
    [
      self.id, 
      Target.where(:id => self.observation_range.observation.target_id)[0].name,
      self.observation_range.observation.date,
      self.observation_range.lo_mhz,
      self.observation_range.hi_mhz,
      self.user_id,
      self.created_at
    ].to_csv
  end
end
