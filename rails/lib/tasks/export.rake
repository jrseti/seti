# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

require 'csv_export'

namespace :export do
  
  desc "Creates CSV files for Assignments and PatternMarks"
  # task :all => [:assignments, :pattern_marks]
    
  desc "Creates CSV file of Assignment objects"
  task :assignments => :environment do
    ::Rails.logger = Logger.new(STDOUT)
    assignments = Assignment.all
    make_csv_from_assignments(assignments, "/tmp/assignments.csv")
  end
  
  # desc "Creates CSV file of PatternMark objects"
  # task :pattern_marks => :environment do
  #   ::Rails.logger = Logger.new(STDOUT)
  #   Observation.all.each do |obs|
  #     populate_observation_ranges(obs)
  #   end
  # end
  
end