require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Import do

  before(:each) do
    @import = Import.make_unsaved
  end

  it "has associated files" do
    @import.files.should == []
  end 

end
