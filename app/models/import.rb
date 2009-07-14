class Import < ActiveRecord::Base

  named_scope :recent, {
    :order => "id DESC"
  }

  has_many :log_entries, :class_name => "ImportLogEntry"

  def log
    @log ||= Log.new(self)
  end

  class Log

    def initialize(import)
      @import = import
    end

    def puts(message)
      @import.log_entries.create!(:content => message)
    end

    def entries
      @import.log_entries.collect(&:content)
    end
    
  end

end
