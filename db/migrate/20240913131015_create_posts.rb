class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.bigint :user_id, null: false

      t.timestamps
    end

    add_index :posts, :user_id
  end
end
