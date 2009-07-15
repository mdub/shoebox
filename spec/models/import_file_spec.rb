require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ImportFile do

  before do
    @import_file = ImportFile.make_unsaved
  end

  it "must be associated with an Import" do
    @import_file.import = nil
    @import_file.should_not be_valid
  end

  it "must have a path" do
    @import_file.path = nil
    @import_file.should_not be_valid
  end

end
