class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body, null: false
      t.bigint :author_id, null: false

      t.timestamps
    end

    add_index :posts, :author_id
  end
end
