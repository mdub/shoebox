class RemoveImportDirectory < ActiveRecord::Migration
  
  def self.up
    remove_column "imports", "directory"
  end

  def self.down
    add_column "imports", "directory", :string, :limit => 200, :null => false
  end
  
end
