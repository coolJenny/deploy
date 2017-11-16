# == Schema Information
#
# Table name: brands
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_brands_on_name  (name) UNIQUE
#

class Brand < ApplicationRecord
  has_many :vendorasin
end
