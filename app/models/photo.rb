require 'action_controller/test_process'
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
  
  validates_uniqueness_of :sha1_digest, :message => "is not unique (duplicate?)"

  named_scope :by_timestamp, :order => "timestamp, id"
 
  named_scope :before, lambda { |timestamp|
    {
      :order =>"timestamp DESC, id DESC",
      :conditions => ["timestamp < ?", timestamp]
    }
  }

  named_scope :after, lambda { |timestamp|
    {
      :order =>"timestamp, id",
      :conditions => ["timestamp > ?", timestamp]
    }
  }
  
  def self.from_file(filename)
    photo = self.new
    content_type = if filename =~ /\.(\w+)$/
      Mime::Type.lookup_by_extension($1).to_s
    end
    photo.uploaded_data = ActionController::TestUploadedFile.new(filename, content_type, true)
    photo
  end
  
  def prior
    self.class.before(timestamp)
  end
  
  def previous
    prior.first
  end

  def subsequent
    self.class.after(timestamp)
  end
  
  def next
    subsequent.first
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
