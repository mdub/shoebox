require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Import do

  before do
    @import = Import.make
  end

  describe "#log" do
    
    it "pretends to be a log-file" do
      @import.log.puts "one"
      @import.log.puts "two"
      
      @import.log.entries.should == ["one", "two"]
    end

  end
  
end
