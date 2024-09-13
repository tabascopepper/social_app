class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.bigint :author_id, null: false
      t.bigint :post_id, null: false
      t.bigint :parent_id

      t.timestamps
    end

    add_index :comments, :author_id
    add_index :comments, :post_id
    add_index :comments, :parent_id
  end
end
