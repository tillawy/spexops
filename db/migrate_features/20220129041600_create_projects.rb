class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.text :name, null: false
      t.text :description

      t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :projects, :discarded_at
  end
end
