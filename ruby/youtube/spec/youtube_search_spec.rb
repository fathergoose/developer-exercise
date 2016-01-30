require "spec_helper"

describe YoutubeSearch do

  describe ".new" do

    it "takes a string and returns a search object" do
      @boat_search = YoutubeSearch.new("boats")
      expect(@boat_search).to be_instance_of(YoutubeSearch)
    end

    it "should search youtube and return search responses" do
      @boat_search = YoutubeSearch.new("boats")
      expect(@boat_search.search_data).to be_instance_of(Array)
    end

  end

  describe "#results" do

    it "is an array" do
      @boat_search = YoutubeSearch.new("boats")
      expect(@boat_search.results).to be_instance_of(Array)
    end

  end
  
end
