class Import < ActiveRecord::Base
  
  named_scope :recent, {
    :order => "id DESC"
  }
  
  has_many :files, :class_name => "ImportFile"
  
  def execute
    files.incomplete.each do |import_file|
      import_file.execute
    end
  end
  
end
