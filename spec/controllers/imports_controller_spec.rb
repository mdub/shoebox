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
      @import = "an Import"
      stub(Import).of_dir(anything) { @import }
      stub(@import).execute_in_background
      post :create, :import => { :directory => "/a/b/c" }
    end
    
    it "creates a new Import" do
      Import.should have_received.of_dir("/a/b/c")
    end

    it "starts the import, as a background job" do
      @import.should have_received.execute_in_background
    end
    
    it "redirects back to index" do
      response.should redirect_to(:action => :index)
    end
    
  end
  
end
