class CreateSchoolEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :school_events do |t|
      t.string :school
      t.string :event_name
      t.date :event_start_date
      t.string :host
      t.float :estimated_cost
      t.datetime :event_end_date
      t.integer :user_id
      t.integer :school_event_payments_count

      t.timestamps
    end
  end
end
