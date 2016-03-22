class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.integer :user_id
      t.integer :newspaper_id
      t.string :memo

      t.timestamps null: false
    end
  end
end
