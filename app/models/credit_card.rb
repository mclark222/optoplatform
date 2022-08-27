# == Schema Information
#
# Table name: credit_cards
#
#  id                   :integer          not null, primary key
#  apr                  :float
#  card_name            :string
#  credit_line          :float
#  current_balance      :float
#  minimum_payment      :float
#  payment_date         :date
#  statement_start_date :date
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  account_id           :integer
#  plaid_account_id     :string
#
class CreditCard < ApplicationRecord
  belongs_to(:account, { :required => true, :class_name => "Account", :foreign_key => "account_id", :counter_cache => true })

end
