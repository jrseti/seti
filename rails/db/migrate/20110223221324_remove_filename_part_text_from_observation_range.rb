class RemoveFilenamePartTextFromObservationRange < ActiveRecord::Migration
  def self.up
    remove_column :observation_ranges, :filename_part_text
  end

  def self.down
    add_column :observation_ranges, :filename_part_text, :string
  end
end
