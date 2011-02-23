class AddBaseUrlToObservation < ActiveRecord::Migration
  def self.up
    add_column :observations, :base_url, :string
  end

  def self.down
    remove_column :observations, :base_url
  end
end
