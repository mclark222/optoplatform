class PlaidItem < ApplicationRecord
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  has_many(:accounts, { :class_name => "Account", :foreign_key => "item_id", :dependent => :destroy })


end
