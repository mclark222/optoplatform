class SchoolEvent < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:school_event_payments, { :class_name => "SchoolEventPayment", :foreign_key => "school_event_id", :dependent => :destroy })


end
