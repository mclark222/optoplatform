# == Schema Information
#
# Table name: loan_disbursements
#
#  id                    :integer          not null, primary key
#  disbursement_amount   :float
#  disbursement_datetime :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  loan_id               :integer
#
class LoanDisbursement < ApplicationRecord
  belongs_to(:loan, { :required => true, :class_name => "CurrentLoan", :foreign_key => "loan_id" })

end
