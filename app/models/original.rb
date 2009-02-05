class Original < ActiveRecord::Base
  
  has_attachment :storage => :file_system, :content_type => :image, :max_size => 2.megabytes

  validates_as_attachment

end
