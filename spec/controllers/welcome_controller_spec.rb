require 'spec_helper'

describe WelcomeController do

  describe "#index" do

    it "should redirect to photos" do
      get :index
      response.should redirect_to(photos_path)
    end

  end

end
