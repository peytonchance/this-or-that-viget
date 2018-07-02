class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :body
      t.references :user, foreign: true
      t.references :poll, foreign: true

      t.timestamps
    end
    
    add_index :comments, [:user_id, :poll_id]
  end
end
