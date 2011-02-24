class AddObservationToPattern < ActiveRecord::Migration
  def self.up
    change_table :patterns do |t|
      t.references :observation
    end
  end

  def self.down
    remove_column :patterns, :observation_id
  end
end
