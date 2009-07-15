class CreateImportFiles < ActiveRecord::Migration
  
  def self.up
    create_table "import_files" do |t|
      t.integer "import_id"
      t.string "path"
      t.text "message"
      t.integer "photo_id"
      t.datetime "completed_at"
      t.timestamps
    end
  end

  def self.down
    drop_table "import_files"
  end

end
