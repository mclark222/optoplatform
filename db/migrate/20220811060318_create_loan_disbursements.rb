class CreateLoanDisbursements < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_disbursements do |t|
      t.integer :loan_id
      t.float :disbursement_amount
      t.datetime :disbursement_datetime

      t.timestamps
    end
  end
end
