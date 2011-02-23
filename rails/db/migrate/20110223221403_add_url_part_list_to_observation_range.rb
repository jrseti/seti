class AddUrlPartListToObservationRange < ActiveRecord::Migration
  def self.up
    add_column :observation_ranges, :url_part_list, :text
  end

  def self.down
    remove_column :observation_ranges, :url_part_list
  end
end
