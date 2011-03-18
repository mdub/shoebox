class Import < ActiveRecord::Base

  named_scope :recent, {
    :order => "id DESC"
  }

  has_many :files, :class_name => "ImportFile", :dependent => :delete_all

  named_scope :complete, {
    :conditions => ["completed_at IS NOT NULL"]
  }

  named_scope :incomplete, {
    :conditions => ["completed_at IS NULL"]
  }

  def self.of_dir(dir_path)
    dir_path = File.expand_path(dir_path)
    file_paths = Dir.glob(File.join(dir_path, "**/*.jpg"))
    self.of_files(file_paths)
  end

  def self.of_files(file_paths)
    self.create!.tap do |import|
      file_paths.each do |f|
        import.files.create!(:path => File.expand_path(f))
      end
    end
  end

  def execute
    return self.completed_at if complete?
    files.incomplete.each do |import_file|
      import_file.execute
      yield(import_file) if block_given?
    end
    self.update_attributes!(:completed_at => Time.now)
  end
  
  def execute_in_background
    Bj.submit "./jobs/execute_import #{self.id}"
  end

  def complete?
    !completed_at.nil?
  end

end
