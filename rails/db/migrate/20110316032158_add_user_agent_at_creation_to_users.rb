class AddUserAgentAtCreationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :user_agent_at_creation, :string
  end

  def self.down
    remove_column :users, :user_agent_at_creation
  end
end
