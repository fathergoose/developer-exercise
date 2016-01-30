require "spec_helper"

describe Search do

  describe ".youtube" do
    it "takes a string and returns a search object" do
      @boat_search = Search.youtube("boats")
      expect(@boat_search).to be_instance_of(Search)
    end
  end
  
end
