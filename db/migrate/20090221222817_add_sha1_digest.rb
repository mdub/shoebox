class AddSha1Digest < ActiveRecord::Migration
  
  def self.up
    add_column "photos", "sha1_digest", :string, :limit => 40
    add_index "photos", ["sha1_digest"], :unique => true
  end

  def self.down
    remove_index "photos", ["sha1_digest"]
    remove_column "photos", "sha1_digest"
  end
  
end
