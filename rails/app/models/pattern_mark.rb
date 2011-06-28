# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class PatternMark < ActiveRecord::Base
  belongs_to :pattern
  belongs_to :assignment
  

  # A Pattern is a correlated set of pattern_marks, from the same observation with a range of frequencies
  # This method will make sure that this pattern_mark is assigned to a pattern correctly, creating or modifying the pattern as needed
  # Note this method does save changes to the pattern, but not to the pattern mark itself.
    
  def assign_to_pattern

    # Figure out which observation we are in
    observation = assignment.observation_range.observation


    # Set up a range of frequencies to look for
    
    mhz_lo = mhz - 0.001
    mhz_hi = mhz + 0.001
    
    
    # Find any patterns that overlap that range
    patterns = Pattern.where(:observation_id => observation.id).where("lo_mhz <= ?", mhz_hi.to_s).where("hi_mhz >= ?", mhz_lo.to_s)


    # If we don't find one, then create one right here
    
    if !patterns.any?
      found_pattern = Pattern.new(:observation_id => observation.id, :lo_mhz => mhz, :hi_mhz => mhz)


    # If we find some, then pick the one that's closest to us (has the lowest 'spread')
    
    else
      spread = 9999.9
      patterns.all.each do |pattern|
        if (spread = 9999.9) || ((mhz - pattern.average_mhz).abs < spread)
          found_pattern = pattern
          spread = (mhz - pattern.average_mhz).abs
        end 
      end
      found_pattern.lo_mhz = [found_pattern.lo_mhz, mhz].min
      found_pattern.hi_mhz = [found_pattern.hi_mhz, mhz].max
      found_pattern.save
    end

    found_pattern.save
    self.pattern = found_pattern
    
  end
  
  def self.csv_header
    %w{pattern_mark_id assignment_id mhz category}.to_csv
  end
  
  def to_csv
    [
      self.id, 
      self.assignment_id,
      self.mhz,
      self.category
    ].to_csv
  end
    
end
