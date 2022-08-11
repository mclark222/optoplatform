class BankAccount < ApplicationRecord
  belongs_to(:account, { :required => true, :class_name => "Account", :foreign_key => "account_id" })

end
