class CreateDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :domains, id: :uuid do |t|
      t.text :name, null: false
      t.text :description

      t.string :ancestry
      t.integer :ancestry_depth, default: 0

      t.belongs_to :project, index: true, foreign_key: true, null: false, type: :uuid

      t.references :parent_domain, foreign_key: {to_table: :domains}, index: true, type: :uuid
      t.integer :child_domains_count, default: 0

      t.datetime :discarded_at
      t.timestamps null: false
    end
    add_index :domains, :ancestry, opclass: :varchar_pattern_ops
    add_index :domains, :discarded_at
  end
end
