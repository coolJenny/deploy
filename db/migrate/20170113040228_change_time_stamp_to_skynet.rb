class ChangeTimeStampToSkynet < ActiveRecord::Migration[5.0]
  def change
    remove_column :skynets, :created_at
    remove_column :skynets, :updated_at
    add_column :skynets, :created_at, :datetime, null: false, :default => Time.now
    add_column :skynets, :updated_at, :datetime, null: false, :default => Time.now
  end
end
