class AttachmentFuToPaperclip < ActiveRecord::Migration
  
  def self.up
    rename_column :photos, :filename, :image_file_name
    rename_column :photos, :content_type, :image_content_type
    rename_column :photos, :size, :image_file_size
  end

  def self.down
    rename_column :photos, :image_file_size, :size
    rename_column :photos, :image_content_type, :content_type
    rename_column :photos, :image_file_name, :filename
  end
  
end
