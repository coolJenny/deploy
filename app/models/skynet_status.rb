# == Schema Information
#
# Table name: skynet_statuses
#
#  id   :integer          not null, primary key
#  name :string(255)
#
# Indexes
#
#  index_skynet_statuses_on_name  (name) UNIQUE
#

class SkynetStatus < ApplicationRecord
  has_many :skynets
end
