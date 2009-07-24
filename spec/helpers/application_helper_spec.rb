require File.dirname(__FILE__) + '/../spec_helper'

describe ApplicationHelper do
  
  describe "#format_datetime" do
    
    describe "with nil input" do
      it "returns null" do
        helper.format_datetime(nil).should == nil
      end
    end

    describe "with datetime input" do
      it "returns short formatted datetime" do
        datetime = Time.now
        mock(datetime).to_s(:short) { "DATETIME" }
        helper.format_datetime(datetime).should == "DATETIME"
      end
    end
    
  end
  
end
