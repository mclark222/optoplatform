class CreateSpendIntentions < ActiveRecord::Migration[6.0]
  def change
    create_table :spend_intentions do |t|
      t.integer :user_id
      t.text :spend_intention

      t.timestamps
    end
  end
end
