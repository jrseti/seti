class AddFilenamePartsToObservationRanges < ActiveRecord::Migration
  def self.up
    add_column :observation_ranges, :filename_part_text, :text
  end

  def self.down
    remove_column :observation_ranges, :filename_part_text
  end
end
