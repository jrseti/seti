$assignments = Assignment.page()
def make_csv_from_assignments(assignments)
  headers = %w{assignment_id other}
  FasterCSV.open("assignments.csv", "w",
                 :write_headers => true, :headers => headers) do |csv|
    assignments.each do |assignment|
      csv << assignment.id
          << assignment.user_id	
          << Target.where(:id => assignment.observation_range.observation.target_id.to_s)[0].name
          << assignment.observation_range.lo_mhz
          << assignment.observation_range.hi_mhz
    end
  end
end
make_csv_from_assignments($assignments)