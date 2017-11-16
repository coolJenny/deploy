class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :addressline1
      t.string :addressline2
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :aws_api_key
      t.string :aws_api_secretkey
      t.string :aws_assoicate_tag
      t.string :mws_api_key
    end
  end
end
