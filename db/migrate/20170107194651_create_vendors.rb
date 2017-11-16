class CreateVendors < ActiveRecord::Migration[5.0]
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :addressline1
      t.string :addressline2
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :account_number
      t.string :contact
      t.string :title
      t.string :phone
      t.string :email
      t.string :website
      t.boolean :dropship
      t.boolean :crossdock
      t.string :login
      t.string :password
      t.string :ref_name
      t.string :ref_title
      t.string :ref_phone
      t.string :ref_email
      t.string :ref_fax
      t.string :ship_fba
      t.string :ship_ltl
      t.string :sticker_unit
      t.string :ship_tier
      t.string :tier_price
      t.string :cc_tran
      t.integer :leadtime, default: 14

      t.references :user, index: true
      t.references :vendor_category, index: true
    end

    add_index :vendors, :name, unique: true
  end
end
