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
  
  def execute
    transaction do
      photo = Photo.from_file(path)
      begin
        if photo.save
          self.photo = photo
        else
          self.message = photo.errors.full_messages.to_yaml
        end
      rescue => e
        self.message = format_exception(e)
      ensure
        self.completed_at = Time.new
        self.save!
      end
    end
  end
  
  private
  
  def format_exception(e)
    %(#{e.class}: #{e.message}\n#{e.backtrace.map { |l| "  at #{l}\n" }.join})
  end
  
end
