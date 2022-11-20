class ConvertAccountIdToBigint < ActiveRecord::Migration[6.0]
  def change
    change_column :transactions, :account_id, :bigint
  end
end
