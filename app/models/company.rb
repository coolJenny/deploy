# == Schema Information
#
# Table name: companies
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  addressline1      :string(255)
#  addressline2      :string(255)
#  city              :string(255)
#  zipcode           :string(255)
#  state             :string(255)
#  aws_api_key       :string(255)
#  aws_api_secretkey :string(255)
#  aws_assoicate_tag :string(255)
#  mws_api_key       :string(255)
#
# Indexes
#
#  index_companies_on_name  (name) UNIQUE
#

class Company < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  
  has_many :users
  has_many :vendors, through: :users
  has_many :skynets, through: :users
  has_many :vendoritems, through: :users
  accepts_nested_attributes_for :users
end
