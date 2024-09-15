class CreateProjectUserMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :project_user_memberships, id: :uuid do |t|

      t.belongs_to :user, index: true, foreign_key: true, null: false, type: :uuid
      t.belongs_to :project, index: true, foreign_key: true, null: false, type: :uuid

      t.integer :role, default: 1, null: false
      t.text :role_description
      t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :project_user_memberships, [:user_id, :project_id], unique: true, where: "(discarded_at is NULL)"
    add_index :project_user_memberships, :discarded_at

  end
end
