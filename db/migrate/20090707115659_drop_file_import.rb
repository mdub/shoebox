class DropFileImport < ActiveRecord::Migration
  
  def self.up
    drop_table "file_imports"
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
  
end
