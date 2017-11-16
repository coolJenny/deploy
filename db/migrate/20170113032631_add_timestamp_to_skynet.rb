class AddTimestampToSkynet < ActiveRecord::Migration[5.0]
  def change
    add_column :skynets, :created_at, :datetime
    add_column :skynets, :updated_at, :datetime
  end
end
