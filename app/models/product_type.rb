# == Schema Information
#
# Table name: product_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_product_types_on_name  (name) UNIQUE
#

class ProductType < ApplicationRecord
  has_many :vendorasin
end
