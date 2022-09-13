class ChangeDataTypeForFees < ActiveRecord::Migration[6.0]
  def change
    change_column :school_fees, :first_fee_date, :date
  end
end
