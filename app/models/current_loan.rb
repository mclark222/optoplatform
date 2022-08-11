class CurrentLoan < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:loan_disbursements, { :class_name => "LoanDisbursement", :foreign_key => "loan_id", :dependent => :destroy })
end
