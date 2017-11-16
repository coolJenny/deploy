class CreateSkynetStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :skynet_statuses do |t|
      t.string :name
    end
    add_index :skynet_statuses, :name,                unique: true
  end
end
