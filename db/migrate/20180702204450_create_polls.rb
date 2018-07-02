class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.string :title
      t.string :option_a
      t.string :option_b
      t.string :option_a_url
      t.string :option_b_url
      t.timestamps
    end
    
    add_reference :polls, :user, foreign_key: true
  end
end
