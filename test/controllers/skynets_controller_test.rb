# == Schema Information
#
# Table name: skynets
#
#  id                :integer          not null, primary key
#  task_id           :string(255)
#  inputfileurl      :string(255)
#  inputfilename     :string(255)
#  idheadername      :string(255)      default("ID")
#  costheadername    :string(255)      default("COST")
#  skuheadername     :string(255)      default("SKU")
#  getestimatesales  :boolean          default(TRUE)
#  getisamazonsale   :boolean          default(TRUE)
#  webhookprogress   :string(255)
#  user_id           :integer
#  vendor_id         :integer
#  skynet_id_type_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  outputfileurl     :string(255)
#  statusmessage     :string(255)
#  skynet_status_id  :integer
#
# Indexes
#
#  index_skynets_on_inputfileurl       (inputfileurl) UNIQUE
#  index_skynets_on_skynet_id_type_id  (skynet_id_type_id)
#  index_skynets_on_skynet_status_id   (skynet_status_id)
#  index_skynets_on_task_id            (task_id) UNIQUE
#  index_skynets_on_user_id            (user_id)
#  index_skynets_on_vendor_id          (vendor_id)
#

require 'test_helper'

class SkynetsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
end
