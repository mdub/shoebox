require 'spec_helper'

describe NavigationHelper do
  
  include NavigationHelper
  
  describe "#nav_link" do

    describe "when href matches current uri" do
      before do
        stub(request).request_uri { "/home" }
      end
      it "classes the link as current" do
        nav_link("Home", "/home").should have_tag(%{a.current})
      end
    end

    describe "when href is a prefix of current uri" do
      before do
        stub(request).request_uri { "/home/foo/bar" }
      end
      it "classes the link as current" do
        nav_link("Home", "/home").should have_tag(%{a.current})
      end
    end

    describe "when href is not a prefix of current uri" do
      before do
        stub(request).request_uri { "/blah" }
      end
      it "does not class the link as current" do
        nav_link("Home", "/home").should_not have_tag(%{a.current})
      end
    end

  end

end
