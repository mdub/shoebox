class Photo < ActiveRecord::Base

  has_attachment(
  {
    :content_type => :image, 
    :max_size => 2.megabytes,
    :storage => :file_system, 
    :path_prefix => "public/var/#{Rails.env}/photos"
  }
  )

  validates_as_attachment

end
