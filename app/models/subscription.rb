# == Schema Information
#
# Table name: subscriptions
#
#  id             :integer          not null, primary key
#  subscriptionid :string(255)
#  amount         :integer
#  interval       :string(255)
#  created        :integer
#
# Indexes
#
#  index_subscriptions_on_subscriptionid  (subscriptionid) UNIQUE
#

class Subscription < ApplicationRecord
  has_many :users
end
