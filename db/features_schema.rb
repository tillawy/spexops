# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2022_01_29_051318) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "pg_stat_statements"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "domains", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.string "ancestry"
    t.integer "ancestry_depth", default: 0
    t.uuid "project_id", null: false
    t.uuid "parent_domain_id"
    t.integer "child_domains_count", default: 0
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ancestry"], name: "index_domains_on_ancestry", opclass: :varchar_pattern_ops
    t.index ["discarded_at"], name: "index_domains_on_discarded_at"
    t.index ["parent_domain_id"], name: "index_domains_on_parent_domain_id"
    t.index ["project_id"], name: "index_domains_on_project_id"
  end

  create_table "feature_point_of_view_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "point_of_view_id", null: false
    t.uuid "feature_id", null: false
    t.uuid "creator_id"
    t.uuid "project_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_feature_point_of_view_memberships_on_creator_id"
    t.index ["discarded_at"], name: "index_feature_point_of_view_memberships_on_discarded_at"
    t.index ["feature_id", "point_of_view_id"], name: "idx_feature_pov_memberships_on_feature_n_pov", unique: true, where: "(discarded_at IS NULL)"
    t.index ["feature_id"], name: "index_feature_point_of_view_memberships_on_feature_id"
    t.index ["point_of_view_id"], name: "index_feature_point_of_view_memberships_on_point_of_view_id"
    t.index ["project_id"], name: "index_feature_point_of_view_memberships_on_project_id"
  end

  create_table "features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.uuid "creator_id"
    t.uuid "domain_id", null: false
    t.uuid "milestone_id", null: false
    t.uuid "project_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_features_on_creator_id"
    t.index ["discarded_at"], name: "index_features_on_discarded_at"
    t.index ["domain_id"], name: "index_features_on_domain_id"
    t.index ["milestone_id"], name: "index_features_on_milestone_id"
    t.index ["project_id"], name: "index_features_on_project_id"
  end

  create_table "milestones", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer "status", default: 1, null: false
    t.uuid "creator_id"
    t.uuid "project_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_milestones_on_creator_id"
    t.index ["discarded_at"], name: "index_milestones_on_discarded_at"
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "point_of_views", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.uuid "creator_id"
    t.uuid "project_id", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_point_of_views_on_creator_id"
    t.index ["discarded_at"], name: "index_point_of_views_on_discarded_at"
    t.index ["project_id"], name: "index_point_of_views_on_project_id"
  end

  create_table "project_user_memberships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "project_id", null: false
    t.integer "role", default: 1, null: false
    t.text "role_description"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_project_user_memberships_on_discarded_at"
    t.index ["project_id"], name: "index_project_user_memberships_on_project_id"
    t.index ["user_id", "project_id"], name: "index_project_user_memberships_on_user_id_and_project_id", unique: true, where: "(discarded_at IS NULL)"
    t.index ["user_id"], name: "index_project_user_memberships_on_user_id"
  end

  create_table "projects", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "name", null: false
    t.text "description"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_projects_on_discarded_at"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.citext "email", null: false
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "domains", "domains", column: "parent_domain_id"
  add_foreign_key "domains", "projects"
  add_foreign_key "feature_point_of_view_memberships", "features"
  add_foreign_key "feature_point_of_view_memberships", "point_of_views"
  add_foreign_key "feature_point_of_view_memberships", "projects"
  add_foreign_key "feature_point_of_view_memberships", "users", column: "creator_id"
  add_foreign_key "features", "domains"
  add_foreign_key "features", "milestones"
  add_foreign_key "features", "projects"
  add_foreign_key "features", "users", column: "creator_id"
  add_foreign_key "milestones", "projects"
  add_foreign_key "milestones", "users", column: "creator_id"
  add_foreign_key "point_of_views", "projects"
  add_foreign_key "point_of_views", "users", column: "creator_id"
  add_foreign_key "project_user_memberships", "projects"
  add_foreign_key "project_user_memberships", "users"
end
