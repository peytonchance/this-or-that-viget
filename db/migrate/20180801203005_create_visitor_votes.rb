class CreateVisitorVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :visitor_votes do |t|
      t.string :ip_address
      t.references :poll, foreign: true
      t.integer :option
      t.timestamps
    end
    add_index :visitor_votes, [:ip_address, :poll_id], unique: true
  end
end
