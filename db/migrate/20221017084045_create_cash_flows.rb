class CreateCashFlows < ActiveRecord::Migration[6.0]
  def change
    create_table :cash_flows do |t|
      t.integer :user_id
      t.date :first_day_of_week
      t.date :last_day_of_week
      t.float :remaining_cash

      t.timestamps
    end
  end
end
