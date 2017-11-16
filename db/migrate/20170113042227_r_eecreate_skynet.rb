class REecreateSkynet < ActiveRecord::Migration[5.0]
  def change
    drop_table :skynets

    create_table :skynets do |t|
      t.string :task_id
      t.string :inputfileurl
      t.string :inputfilename
      t.string :idheadername, default: "ID"
      t.string :costheadername, default: "COST"
      t.string :skuheadername, default: "SKU"
      t.boolean :getestimatesales, default: true
      t.boolean :getisamazonsale, default: true
      t.string :webhookprogress
      t.references :user, index: true
      t.references :vendor, index: true
      t.references :skynet_id_type, index: true
      t.timestamps null: false      
    end
    add_index :skynets, :task_id,                unique: true
    add_index :skynets, :inputfileurl,           unique: true
  end
end
