class Account < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:bank_accounts, { :class_name => "BankAccount", :foreign_key => "account_id", :dependent => :destroy })
  has_many(:transactions, { :class_name => "Transaction", :foreign_key => "account_id", :dependent => :destroy })
  has_many(:credit_cards, { :class_name => "CreditCard", :foreign_key => "account_id", :dependent => :destroy })
  belongs_to(:item, { :required => true, :class_name => "PlaidItem", :foreign_key => "item_id", :counter_cache => true })

end
