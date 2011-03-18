require 'spec_helper'

describe PhotosController do

  describe "#index" do

    it "exposes a paginated list of photos" do
      
      @paginated_photos = ["paginated list of photos"].paginate
      mock(Photo).paginate(:page => "3") do
        @paginated_photos
      end

      get :index, :page => 3

      assigns[:photos].should == @paginated_photos
      
    end

  end

  describe "#show" do

    describe "with a valid photo id" do

      before do
        @photo = stub_model(Photo)
        mock(Photo).find(@photo.id.to_s) { @photo }

        @prior_photos = [stub_model(Photo)]
        stub(@photo).prior.stub!.all { @prior_photos }

        @subsequent_photos = [stub_model(Photo)]
        stub(@photo).subsequent.stub!.all { @subsequent_photos }
        
        get :show, :id => @photo.id
      end

      it "exposes the photo" do
        assigns[:photo].should == @photo
      end

      it "exposes prior_photos" do
        assigns[:prior_photos].should == @prior_photos
      end
      
      it "exposes subsequent_photos" do
        assigns[:subsequent_photos].should == @subsequent_photos
      end

    end

  end

end
