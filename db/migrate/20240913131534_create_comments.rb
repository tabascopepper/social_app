class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.bigint :user_id, null: false
      t.bigint :post_id, null: false

      t.timestamps
    end

    add_index :comments, :user_id
    add_index :comments, :post_id
  end
end
