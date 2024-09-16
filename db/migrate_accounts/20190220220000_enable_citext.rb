class EnableCitext < ActiveRecord::Migration[6.0]
  def change
    enable_extension 'citext' unless extension_enabled?("citext")
  end
end