# This migration creates the `versions` table, the only schema PT requires.
# All other migrations PT provides are optional.
class CreateVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :versions, id: :uuid do |t|
      t.string :item_type, null: false
      t.string :item_id, null: false
      t.string :event, null: false
      t.string :transaction_id
      t.string :request_id
      t.string :ip_address
      t.string :user_agent
      t.string :whodunnit
      t.jsonb :object
      t.jsonb :object_changes
      t.datetime :created_at
    end
    add_index :versions, %i[item_type item_id]
  end
end
