class Import < ActiveRecord::Base
  
  named_scope :recent, {
    :order => "id DESC"
  }
  
  has_many :files, :class_name => "ImportFile"
  
end
