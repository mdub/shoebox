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

  def self.from_file(filename)
    photo = self.new
    content_type = if filename =~ /\.(\w+)$/
      Mime::Type.lookup_by_extension($1).to_s
    end
    photo.uploaded_data = ActionController::TestUploadedFile.new(filename, content_type, true)
    photo
  end

  def prev_id
    id - 1
  end

  def next_id
    id + 1
  end
  
end
