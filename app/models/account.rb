# == Schema Information
#
# Table name: accounts
#
#  id                      :integer          not null, primary key
#  account_type            :string
#  available_balance_plaid :float
#  credit_cards_count      :integer
#  current_balance_plaid   :float
#  iso_currency_code_plaid :text
#  mask_plaid              :text
#  name_plaid              :text
#  official_name_plaid     :text
#  subtype_plaid           :text
#  type_plaid              :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  item_id                 :integer
#  plaid_account_id        :text
#  user_id                 :integer
#
class Account < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:bank_accounts, { :class_name => "BankAccount", :foreign_key => "account_id", :dependent => :destroy })
  has_many(:transactions, { :class_name => "Transaction", :foreign_key => "account_id", :dependent => :destroy })
  has_many(:credit_cards, { :class_name => "CreditCard", :foreign_key => "account_id", :dependent => :destroy })
  belongs_to(:item, { :required => true, :class_name => "PlaidItem", :foreign_key => "item_id", :counter_cache => true })

end
