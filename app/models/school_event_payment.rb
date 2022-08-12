# == Schema Information
#
# Table name: school_event_payments
#
#  id                   :integer          not null, primary key
#  payment_amount       :float
#  payment_due_datetime :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  school_event_id      :integer
#
class SchoolEventPayment < ApplicationRecord
  belongs_to(:school_event, { :required => true, :class_name => "SchoolEvent", :foreign_key => "school_event_id", :counter_cache => true })

end
