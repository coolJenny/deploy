class ChangeVendorAsin < ActiveRecord::Migration[5.0]
  def change
    change_column :vendorasins, :salespermonth, :decimal, default: 0
    change_column :vendorasins, :commissionpct, :decimal, default: 0
    change_column :vendorasins, :commissiionfee, :decimal, default: 0
    change_column :vendorasins, :totaloffers, :integer, default: 0
    change_column :vendorasins, :fbaoffers, :integer, default: 0
    change_column :vendorasins, :fbmoffers, :integer, default: 0
    change_column :vendorasins, :fbafee, :decimal, default: 0
    change_column :vendorasins, :storagefee, :decimal, default: 0
    change_column :vendorasins, :variableclosingfee, :decimal, default: 0
    change_column :vendorasins, :lowestfbaoffer, :decimal, default: 0
    change_column :vendorasins, :lowestfbmoffer, :decimal, default: 0
    change_column :vendorasins, :isbuyboxfba, :boolean, default: false

    remove_column :vendorasins, :salesrankcategory
    remove_column :vendorasins, :profit
  end
end
