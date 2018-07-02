class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign: true
      t.references :poll, foreign: true
      t.timestamps
    end
  end
end
