class ImportFile < ActiveRecord::Base

  belongs_to :import
  validates_presence_of :import

  validates_presence_of :path

  belongs_to :photo

  named_scope :complete, {
    :conditions => ["completed_at IS NOT NULL"]
  }

  named_scope :incomplete, {
    :conditions => ["completed_at IS NULL"]
  }

  named_scope :failed, {
    :conditions => ["message IS NOT NULL"]
  }

  named_scope :successful, {
    :conditions => ["message IS NULL"]
  }

  def execute
    transaction do
      photo = Photo.from_file(path)
      if photo.save
        self.photo = photo
      else
        self.message = photo.errors.full_messages.to_yaml
      end
      self.completed_at = Time.new
      self.save!
    end
  end

  def messages
    YAML.load(message) if message
  end
  
  def complete?
    !completed_at.nil?
  end

  def succeeded?
    message.blank?
  end

  def failed?
    !succeeded?
  end
  
end
