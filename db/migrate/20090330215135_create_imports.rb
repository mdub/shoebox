class CreateImports < ActiveRecord::Migration
  
  def self.up

    create_table "imports" do |t|
      t.string "directory", :null => false, :limit => 200
      t.datetime "completed_at"
      t.timestamps
    end

  end

  def self.down
    drop_table "imports"
  end
  
end
