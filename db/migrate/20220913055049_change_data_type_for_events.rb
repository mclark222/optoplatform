class ChangeDataTypeForEvents < ActiveRecord::Migration[6.0]
  def change
      change_column :school_events, :event_end_date, :date
  end
end
