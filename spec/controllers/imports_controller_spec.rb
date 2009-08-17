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

  describe "#create" do

    before do
      Import.destroy_all
    end
    
    it "creates a new Import" do
      @import = "an Import"
      mock(Import).of_dir("/a/b/c") { @import }
      post :create, :import => { :directory => "/a/b/c" }
    end

    it "redirects back to index" do
      response.should redirect_to(:action => :index)
    end
    
  end
  
end
