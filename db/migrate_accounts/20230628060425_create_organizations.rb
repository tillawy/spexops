class CreateOrganizations < ActiveRecord::Migration[7.0]
  def change
    create_table :organizations, id: :uuid do |t|
      t.text :name, null: false, uniq: true
      t.citext :domain, null: true, uniq: true
      t.datetime :discarded_at
      t.timestamps
    end
    add_index :organizations, :discarded_at
  end
end
