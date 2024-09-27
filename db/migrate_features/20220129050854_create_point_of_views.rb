class CreatePointOfViews < ActiveRecord::Migration[7.0]
  def change
    create_table :point_of_views, id: :uuid do |t|
      t.text :name, null: false
      t.text :description

      t.belongs_to :creator, index: true, foreign_key: { to_table: :users }, type: :uuid
      t.belongs_to :project, index: true, foreign_key: true, null: false, type: :uuid


      t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :point_of_views, :discarded_at
  end
end
