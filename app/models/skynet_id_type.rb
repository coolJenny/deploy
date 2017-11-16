# == Schema Information
#
# Table name: skynet_id_types
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class SkynetIdType < ApplicationRecord
  has_many :skynets
end
