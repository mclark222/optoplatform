class LoanDisbursement < ApplicationRecord
  belongs_to(:loan, { :required => true, :class_name => "CurrentLoan", :foreign_key => "loan_id" })

end
