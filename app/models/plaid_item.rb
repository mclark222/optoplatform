# == Schema Information
#
# Table name: plaid_items
#
#  id                   :bigint           not null, primary key
#  accounts_count       :integer
#  plaid_access_token   :text
#  status               :text
#  transactions_cursor  :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  plaid_institution_id :text
#  plaid_item_id        :text
#  user_id              :integer
#
class PlaidItem < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:accounts, { :class_name => "Account", :foreign_key => "item_id", :dependent => :destroy })

end
