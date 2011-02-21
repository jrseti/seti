class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.references :observation_range
      t.references :user
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
