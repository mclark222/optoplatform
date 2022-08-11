class Transaction < ApplicationRecord
  belongs_to(:spend_category, { :required => true, :class_name => "TransactionCategory", :foreign_key => "spend_category_id" })
  belongs_to(:account, { :required => true, :class_name => "Account", :foreign_key => "account_id" })


end
