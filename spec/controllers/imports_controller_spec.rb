require File.dirname(__FILE__) + '/../spec_helper'

describe ImportsController do
  
  describe "#index" do
    
    it "lists imports, by date" do
      @imports = "collection of imports"
      stub(Import).recent.stub!.all { @imports }

      get :index

      assigns[:imports].should == @imports
    end
    
  end
  
end
