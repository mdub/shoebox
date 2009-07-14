class Import < ActiveRecord::Base
  
  named_scope :recent, {
    :order => "id DESC"
  }
  
end
