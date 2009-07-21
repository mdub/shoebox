class Import < ActiveRecord::Base

  named_scope :recent, {
    :order => "id DESC"
  }

  has_many :files, :class_name => "ImportFile"

  named_scope :complete, {
    :conditions => ["completed_at IS NOT NULL"]
  }

  named_scope :incomplete, {
    :conditions => ["completed_at IS NULL"]
  }

  def self.of_dir(dir_path)
    returning (self.create!) do |import|
      dir_path = File.expand_path(dir_path)
      Dir.glob(File.join(dir_path, "**/*.jpg")).each do |jpg|
        import.files.create!(:path => jpg)
      end
    end
  end

  def execute
    return self.completed_at if complete?
    files.incomplete.each do |import_file|
      import_file.execute
    end
    self.update_attributes!(:completed_at => Time.now)
  end

  def complete?
    !completed_at.nil?
  end

end
