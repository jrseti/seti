class CreatePatternMarks < ActiveRecord::Migration
  def self.up
    create_table :pattern_marks do |t|
      t.decimal :mhz
      t.string :category
      t.date :date
      t.references :pattern
      t.references :assignment

      t.timestamps
    end
  end

  def self.down
    drop_table :pattern_marks
  end
end
