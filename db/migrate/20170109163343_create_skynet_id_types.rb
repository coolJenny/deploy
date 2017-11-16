class CreateSkynetIdTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :skynet_id_types do |t|
      t.string :name
    end
  end
end
