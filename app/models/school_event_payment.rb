class SchoolEventPayment < ApplicationRecord
  belongs_to(:school_event, { :required => true, :class_name => "SchoolEvent", :foreign_key => "school_event_id", :counter_cache => true })

end
