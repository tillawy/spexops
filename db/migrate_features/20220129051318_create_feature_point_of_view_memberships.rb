class CreateFeaturePointOfViewMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :feature_point_of_view_memberships, id: :uuid do |t|

      t.belongs_to :point_of_view, index: true, foreign_key: true, null: false, type: :uuid
      t.belongs_to :feature, index: true, foreign_key: true, null: false, type: :uuid
      t.belongs_to :creator, index: true, foreign_key: {to_table: :users}, type: :uuid
      t.belongs_to :project, index: true, foreign_key: true, null: false, type: :uuid

      t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :feature_point_of_view_memberships, [:feature_id, :point_of_view_id],
              unique: true,
              name: 'idx_feature_pov_memberships_on_feature_n_pov',
              where: "(discarded_at is NULL)"
    add_index :feature_point_of_view_memberships, :discarded_at
  end
end
