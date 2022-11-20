# == Schema Information
#
# Table name: bank_accounts
#
#  id                   :integer          not null, primary key
#  account_balance      :float
#  savings_account_flag :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :integer
#  asset_id             :integer
#  plaid_account_id     :string
#
class BankAccount < ApplicationRecord
  belongs_to(:account, { :required => true, :class_name => "Account", :foreign_key => "account_id" })

end
