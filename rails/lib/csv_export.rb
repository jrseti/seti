require "faster_csv"
                    
def make_csv_from_assignments(assignments, file_name)
  headers = %w{assignment_id target observation_date observation_range_lo observation_range_hi user_id}
  FasterCSV.open(file_name, "w", :write_headers => true, :headers => headers) do |csv|
    assignments.each do |assignment|
      csv << [
        assignment.id, 
        Target.where(:id => assignment.observation_range.observation.target_id)[0].name,
        assignment.observation_range.observation.date,
        assignment.observation_range.lo_mhz,
        assignment.observation_range.hi_mhz,
        assignment.user_id
      ]
    end
  end
end