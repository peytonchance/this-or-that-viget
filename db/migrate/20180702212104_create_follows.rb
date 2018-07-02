class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, foreign: true
      t.references :poll, foreign: true
      t.timestamps
    end
    add_index :follows, [:user_id, :poll_id], unique: true

  end
end
