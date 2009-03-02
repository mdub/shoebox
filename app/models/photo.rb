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
  
  before_validation :extract_details_from_original
  
  validates_uniqueness_of :sha1_digest, :message => "duplicates an existing photo"

  named_scope :by_timestamp, :order => "timestamp, id"
  named_scope :by_timestamp_desc, :order => "timestamp desc, id desc"
  
  def self.from_file(filename)
    photo = self.new
    content_type = if filename =~ /\.(\w+)$/
      Mime::Type.lookup_by_extension($1).to_s
    end
    photo.uploaded_data = ActionController::TestUploadedFile.new(filename, content_type, true)
    photo
  end
  
  def previous
    self.class.by_timestamp_desc.find(:first, :conditions => ["timestamp < ?", timestamp])
  end
  
  def next
    self.class.by_timestamp.find(:first, :conditions => ["timestamp > ?", timestamp])
  end

  protected
  
  def extract_details_from_original
    return false unless save_attachment?
    self.sha1_digest = Digest::SHA1.hexdigest(temp_data)
    if content_type == "image/jpeg"
      self.timestamp = EXIFR::JPEG.new(temp_path).date_time
    end
  end
  
end
