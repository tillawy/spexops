class CreateOrganizationUserMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :organization_user_memberships, id: :uuid do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false, type: :uuid
      t.belongs_to :organization, index: true, foreign_key: true, null: false, type: :uuid
      t.integer :invitation_status, default: 1, null: false
      t.integer :role, default: 1, null: false

      t.datetime :discarded_at
      t.timestamps
    end
    add_index :organization_user_memberships, [:user_id, :organization_id], unique: true, name: "index_organization_user_memberships_uniqueness", where: "(discarded_at is NULL)"
    add_index :organization_user_memberships, :discarded_at
  end
end
