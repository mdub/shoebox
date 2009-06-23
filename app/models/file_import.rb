class FileImport < ActiveRecord::Base
  
  belongs_to :import
  validates_presence_of :import

  validates_presence_of :filename
  
  belongs_to :photo
  
end
