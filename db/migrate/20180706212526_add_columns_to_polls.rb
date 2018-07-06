class AddColumnsToPolls < ActiveRecord::Migration[5.2]
  def change
    add_column :polls, :expiry_time, :datetime
    add_column :polls, :expired, :boolean
  end
end
