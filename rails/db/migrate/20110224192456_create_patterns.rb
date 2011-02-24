class CreatePatterns < ActiveRecord::Migration
  def self.up
    create_table :patterns do |t|
      t.decimal :lo_mhz
      t.decimal :hi_mhz
      t.string :category
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :patterns
  end
end
