class RemoveUrlFormatFromObservation < ActiveRecord::Migration
  def self.up
    remove_column :observations, :url_format
  end

  def self.down
    add_column :observations, :url_format, :string
  end
end
