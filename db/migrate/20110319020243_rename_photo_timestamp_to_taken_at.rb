class RenamePhotoTimestampToTakenAt < ActiveRecord::Migration
  
  def self.up
    rename_column :photos, :timestamp, :taken_at
  end

  def self.down
    rename_column :photos, :taken_at, :timestamp
  end
  
end
