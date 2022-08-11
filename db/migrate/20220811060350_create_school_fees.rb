class CreateSchoolFees < ActiveRecord::Migration[6.0]
  def change
    create_table :school_fees do |t|
      t.string :fee_name
      t.datetime :first_fee_date
      t.string :school
      t.float :fee_amount
      t.string :term
      t.integer :year

      t.timestamps
    end
  end
end
