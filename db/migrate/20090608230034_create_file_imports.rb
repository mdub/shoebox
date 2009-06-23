class CreateFileImports < ActiveRecord::Migration
  
  def self.up
    create_table "file_imports" do |t|
      t.integer "import_id", :null => false
      t.string "filename", :null => false, :limit => 250
      t.integer "photo_id", :null => true
      t.datetime "completed_at"
    end
  end

  def self.down
    drop_table "file_imports"
  end
  
end
