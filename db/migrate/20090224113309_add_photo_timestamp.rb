class AddPhotoTimestamp < ActiveRecord::Migration
  
  def self.up
    add_column "photos", "timestamp", :timestamp
    add_index "photos", ["timestamp"]
  end

  def self.down
    remove_index "photos", ["timestamp"]
    remove_column "photos", "timestamp"
  end
  
end
