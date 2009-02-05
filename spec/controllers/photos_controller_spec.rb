require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhotosController do

  describe "#index" do

    before do
      @photos = [mock_model(Photo)]
      mock(Photo).find(:all) { @photos }
      get :index
    end
    
    it "exposes a list of photos index" do
      assigns(:photos).should == @photos
    end

    it "renders index template" do
      response.should render_template("photos/index")
    end

  end

end
