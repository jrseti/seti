require 'seti_populate'

namespace :populate do
  
  desc "Populate targets, observations, and observation ranges from SETI data"
  task :all => [:observations, :ranges]
    
  desc "Populate targets and observations from SETI data"
  task :observations => :environment do
    ::Rails.logger = Logger.new(STDOUT)
    populate_targets_observations
  end
  
  desc "Populate observation ranges for all observations from SETI data"
  task :ranges => :environment do
    ::Rails.logger = Logger.new(STDOUT)
    Observation.all.each do |obs|
      populate_observation_ranges(obs)
    end
  end
  
  desc "Destroy all targets, observations, and observation ranges"
  task :destroy => :environment do
    ::Rails.logger = Logger.new(STDOUT)
    Target.destroy_all
    Observation.destroy_all
    ObservationRange.destroy_all
  end
  
end