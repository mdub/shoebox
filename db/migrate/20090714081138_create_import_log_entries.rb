class CreateImportLogEntries < ActiveRecord::Migration
  
  def self.up
    create_table "import_log_entries", :force => true do |t|
      t.integer "import_id"
      t.text "content"
    end
  end

  def self.down
    drop_table "import_log_entries"
  end
  
end
