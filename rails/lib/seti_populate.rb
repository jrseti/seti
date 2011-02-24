# This method populates Targets and Observations, using a text file provided by SETI.
# It basically follows the instructions here: https://github.com/hathersagegroup/seti/wiki/Populating-Targets-and-Observations

# This method is designed to be either called from a controller, or run using the Rails console or runner, like so:
#   rails runner 'require "./lib/populate_targets_observations"; populate_targets_observations'

# It will return a hash containing two keys -- :observations and :targets -- whose values are arrays of record IDs
# for Observations and Targets, respectively.

require 'open-uri'

OBSERVATIONS_URI = 'http://setiquest.dyndns.org/getobservations.php'

def populate_targets_observations
  
  new_records = {
    :observations => [],
    :targets => []
  }
  
  # Load http://setiquest.dyndns.org/getobservations.php
  # Parse the fixed width file

  ::Rails.logger.info "fetching observations: #{OBSERVATIONS_URI}"

  open(OBSERVATIONS_URI).readlines.each do |line|
    
    # For each observation

    line.chomp!
    next if line.empty?
    
    # Date -> ignore
    # Name -> Keep. Will use as Target.name
    # Right ascension -> Target.right_ascension
    # Declination -> Target.declination Note that these files are not entirely consistent with each other in terms of formatting.
    # Frequency -> ignore
    # start time -> Will use as Observation.date
    # URL -> Keep. Will use as Observation.base_url
        
    line.chomp =~ /^(\S+)\s+"(.+?)"\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/ or begin
      ::Rails.logger.error "Can't parse observation line: #{line.inspect}"
      next
    end
        
    date,
    name, 
    right_ascension,
    declination,
    frequency,
    timestamp,
    base_url = $1, $2, $3.to_f, $4.to_f, $5.to_f, $6.to_datetime, $7
    
    # Figure out whether we already have it in the database by looking up the base_url. If we already have this observation, then stop.

    if Observation.find_by_base_url(base_url)
      ::Rails.logger.info "skipping existing observation: #{base_url.inspect}"
      next
    end
    
    # Now we need to see if we already have the target. Look up by right_ascension and declination. 
    # Sometimes the institute reverses the sign on the declination, so we have to check both the positive and negative versions of the declination.
    
    target = Target.find_by_right_ascension_and_declination(right_ascension, declination) ||
             Target.find_by_right_ascension_and_declination(right_ascension, -declination)
    
    if target
      ::Rails.logger.info "found existing target: #{target.inspect}"
    else
      # If we do not already have the Target, then add it. Set the name, description, and coordinates as shown above.
      target = Target.new(
        :name => name,
        :description => '',
        :right_ascension => right_ascension,
        :declination => declination)
      target.save!
      new_records[:targets] << target.id
      ::Rails.logger.info "created new target: #{target.inspect}"
    end

    # Then add the Observation. Set the date/time and analysis base_url as shown above
    
    observation = Observation.new(
      :date => timestamp,
      :base_url => base_url,
      :target => target)
    observation.save!
    new_records[:observations] << observation.id
    ::Rails.logger.info "created new observation: #{observation.inspect}"
    
  end
  
  new_records
end

# If we're running this in the console, set up the Logger so we can see what's happening
if $0 == 'script/rails'
  ::Rails.logger = Logger.new(STDOUT)
end