# frozen_string_literal: true

class EnablePgStatStatements < ActiveRecord::Migration[7.1]
  def change
    enable_extension "pg_stat_statements" unless extension_enabled?("pg_stat_statements")
  end
end
