require File.dirname(__FILE__) + '/../../spec_helper'

describe "photos/index" do
  
  describe "with 3 photos" do
    assigns[:photos] = (1..3).map { mock_model(Photo) }
  end
  
end
