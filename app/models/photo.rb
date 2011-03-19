require 'digest/sha1'
require 'shellwords'

class Photo < ActiveRecord::Base

  has_attached_file :image, :url => "/system/:class/:attachment_fu_id/:filename"
  validates_attachment_presence :image
  
  after_image_post_process :extract_details_from_image
  
  validates_uniqueness_of :sha1_digest, :message => "is not unique; looks like this is a duplicate"

  scope :by_id, {
    :order => "id"
  }
 
  scope :before, lambda { |id|
    {
      :order => "id DESC",
      :conditions => ["id < ?", id]
    }
  }

  scope :after, lambda { |id|
    {
      :order => "id",
      :conditions => ["id > ?", id]
    }
  }
  
  def self.from_file(filename)
    self.new.tap do |photo|
      photo.image = File.new(filename)
      if filename.to_str =~ /\.(\w+)$/
        photo.image_content_type = Mime::Type.lookup_by_extension($1.downcase).to_s
      end
    end
  end
  
  def content_type
    image_content_type
  end

  def filename
    image_file_name
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
      raise "Command '#{Shellwords.join(command)}' failed with exit status #{$?.exitstatus}"
    end
  end
  
  protected
  
  def extract_details_from_image
    image_tempfile = image.queued_for_write[:original]
    if image_tempfile
      self.sha1_digest = Digest::SHA1.hexdigest(image_tempfile.read)
      if image_tempfile.content_type == "image/jpeg"
        self.timestamp = EXIFR::JPEG.new(image_tempfile.path).date_time
      end
    end
  end
  
end
