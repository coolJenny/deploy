class CreateSkynets < ActiveRecord::Migration[5.0]
  def change
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
      t.references :buyer, index: true
      t.references :skynet_id_type, index: true      
    end
    add_index :skynets, :task_id,                unique: true
    add_index :skynets, :inputfileurl,                unique: true
  end
end
