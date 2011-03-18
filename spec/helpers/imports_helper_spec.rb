require 'spec_helper'

describe ImportsHelper do

  include ImportsHelper
  
  before do
    @import_file = ImportFile.make_unsaved
    stub(@import_file).complete? { true }
  end
  
  describe "for an incomplete ImportFile" do

    before do
      stub(@import_file).complete? { false }
    end
    
    describe "#import_file_status" do
      it "returns an unstyled dot" do
        import_file_status(@import_file).should == ImportsHelper::PENDING
      end
    end
    
  end

  describe "for a failed ImportFile" do

    before do
      stub(@import_file).failed? { true }
    end
    
    describe "#import_file_status" do
      it "returns a problematic cross" do
        import_file_status(@import_file).should have_tag(".problematic", ImportsHelper::FAILED)
      end
    end
    
  end

  describe "for a successful ImportFile" do

    before do
      stub(@import_file).failed? { false }
    end
    
    describe "#import_file_status" do
      it "is laid-back" do
        import_file_status(@import_file).should have_tag(".okay", ImportsHelper::DONE)
      end
    end
    
  end

end
