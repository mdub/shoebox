require 'action_controller/test_process'
require 'digest/sha1'

class Photo < ActiveRecord::Base

  has_attachment(
  {
    :content_type => :image, 
    :max_size => 4.megabytes,
    :storage => :file_system, 
    :path_prefix => "public/system/photos"
  }
  )

  validates_as_attachment
  
  before_validation :extract_details_from_original
  
  validates_uniqueness_of :sha1_digest, :message => "is not unique; looks like this is a duplicate"

  named_scope :by_id, {
    :order => "id"
  }
 
  named_scope :before, lambda { |id|
    {
      :order => "id DESC",
      :conditions => ["id < ?", id]
    }
  }

  named_scope :after, lambda { |id|
    {
      :order => "id",
      :conditions => ["id > ?", id]
    }
  }
  
  def self.from_file(filename)
    filename = filename.to_str
    photo = self.new
    content_type = if filename =~ /\.(\w+)$/
      Mime::Type.lookup_by_extension($1).to_s
    end
    photo.uploaded_data = ActionController::TestUploadedFile.new(filename, content_type, true)
    photo
  end
  
  def prior
    self.class.before(id)
  end
  
  def previous
    prior.first
  end

  def subsequent
    self.class.after(id)
  end
  
  def next
    subsequent.first
  end

  def write_variant(*convert_args)
    command = ["convert", full_filename] + convert_args
    unless system(*command)
      raise "Command #{command.inspect} failed with exit status #{$?.exitstatus}"
    end
  end
  
  protected
  
  def extract_details_from_original
    return nil unless save_attachment?
    self.sha1_digest = Digest::SHA1.hexdigest(temp_data)
    if content_type == "image/jpeg"
      self.timestamp = EXIFR::JPEG.new(temp_path).date_time
    end
  end
  
end
