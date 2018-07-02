class AddColumnToVotes < ActiveRecord::Migration[5.2]
  def change
    add_column :votes, :option, :integer
  end
end
