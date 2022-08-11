class CreateSchoolEventPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :school_event_payments do |t|
      t.datetime :payment_due_datetime
      t.float :payment_amount
      t.integer :school_event_id

      t.timestamps
    end
  end
end
