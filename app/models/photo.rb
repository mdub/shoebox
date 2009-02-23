require 'digest/sha1'

class Photo < ActiveRecord::Base

  has_attachment(
  {
    :content_type => :image, 
    :max_size => 4.megabytes,
    :storage => :file_system, 
    :path_prefix => "public/var/#{Rails.env}/photos"
  }
  )

  validates_as_attachment
  
  before_validation :set_sha1_digest_from_temp_data
  
  validates_uniqueness_of :sha1_digest, :message => "duplicates an existing photo"

  def self.from_file(filename)
    photo = self.new
    content_type = if filename =~ /\.(\w+)$/
      Mime::Type.lookup_by_extension($1).to_s
    end
    photo.uploaded_data = ActionController::TestUploadedFile.new(filename, content_type, true)
    photo
  end

  def previous
    self.class.find_by_id(id - 1)
  end
  
  def next
    self.class.find_by_id(id + 1)
  end

  protected
  
  def set_sha1_digest_from_temp_data
    if save_attachment?
      self.sha1_digest = Digest::SHA1.hexdigest(temp_data)
    end
  end
  
end
