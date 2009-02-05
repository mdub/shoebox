require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Original do
  
  describe "uploaded original" do

    before do
      @original = Original.create!(:uploaded_data => fixture_file_upload("images/ngara-on-train.jpg", "image/jpg"))
    end

    it "is stored in /public/originals" do
      @original.public_filename.should =~ %r{^/originals/.*/ngara-on-train\.jpg$}
      image_file_path = "#{RAILS_ROOT}/public#{@original.public_filename}"
      Pathname(image_file_path).should exist
    end

  end
end
