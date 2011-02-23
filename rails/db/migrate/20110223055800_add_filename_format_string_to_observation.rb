class AddFilenameFormatStringToObservation < ActiveRecord::Migration
  def self.up
    add_column :observations, :url_format, :string
  end

  def self.down
    remove_column :observations, :url_format
  end
end
