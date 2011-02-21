class CreateObservationRanges < ActiveRecord::Migration
  def self.up
    create_table :observation_ranges do |t|
      t.references :observation
      t.decimal :lo_mhz
      t.decimal :hi_mhz
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :observation_ranges
  end
end
