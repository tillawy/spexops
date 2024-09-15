class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|

      t.citext :email, null: false

      t.datetime :discarded_at
      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :discarded_at
  end
end
