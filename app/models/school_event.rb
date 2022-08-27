# == Schema Information
#
# Table name: school_events
#
#  id                          :integer          not null, primary key
#  estimated_cost              :float
#  event_end_date              :datetime
#  event_name                  :string
#  event_start_date            :date
#  host                        :string
#  school                      :string
#  school_event_payments_count :integer
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :integer
#
class SchoolEvent < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:school_event_payments, { :class_name => "SchoolEventPayment", :foreign_key => "school_event_id", :dependent => :destroy })


end
