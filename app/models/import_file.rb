class ImportFile < ActiveRecord::Base
  
  belongs_to :import
  validates_presence_of :import
  
  validates_presence_of :path
  
end
