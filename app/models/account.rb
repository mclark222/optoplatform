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
  belongs_to :user
  
  # No idea about the need of bank accounts & credit card account model here
  has_many(:bank_accounts, { :class_name => "BankAccount", :foreign_key => "account_id", :dependent => :destroy })
  has_many(:credit_cards, { :class_name => "CreditCard", :foreign_key => "account_id", :dependent => :destroy })


  has_many :transactions, dependent: :destroy
  belongs_to :item, foreign_key: :item_id, class_name: 'PlaidItem', counter_cache: true
end
