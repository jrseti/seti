class CreateTargets < ActiveRecord::Migration
  def self.up
    create_table :targets do |t|
      t.string :name
      t.text :description
      t.decimal :right_ascension, :precision=>15, :scale=>12
      t.decimal :declination, :precision=>15, :scale=>12

      t.timestamps
    end
  end

  def self.down
    drop_table :targets
  end
end
