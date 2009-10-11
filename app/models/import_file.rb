class ImportFile < ActiveRecord::Base

  belongs_to :import
  validates_presence_of :import

  validates_presence_of :path

  belongs_to :photo

  named_scope :by_id, {
    :order => "id ASC"
  }

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
      if File.exists?(path)
        import_the_photo
      else
        self.messages = [%{No such file: #{path.inspect}}]
      end
      self.completed_at = Time.new
      self.save!
    end
  end

  def messages=(messages)
    self.message = messages.to_yaml
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
  
  private

  def import_the_photo
    photo = Photo.from_file(path)
    if photo.save
      self.photo = photo
    else
      self.messages = photo.errors.full_messages
    end
  end
  
end
