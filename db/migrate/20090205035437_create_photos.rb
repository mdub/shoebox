class CreatePhotos < ActiveRecord::Migration

  def self.up
    create_table "photos" do |t|
      t.string   "filename", :limit => 100
      t.string   "content_type", :limit => 50
      t.integer  "size"
      t.integer  "height"
      t.integer  "width"
      t.timestamps
    end
  end

  def self.down
    drop_table "photos"
  end

end
