# == Schema Information
#
# Table name: spend_intentions
#
#  id              :integer          not null, primary key
#  spend_intention :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_id         :integer
#
class SpendIntention < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })

end
