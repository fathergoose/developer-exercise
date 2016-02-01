require "spec_helper"

describe YoutubeSearch do

  before :each do
    @boat_search = YoutubeSearch.new("boats")
  end

  describe ".new" do

    it "takes a string and returns a search object" do
      expect(@boat_search).to be_instance_of(YoutubeSearch)
    end

    it "should return search data as an array of hashes" do
      expect(@boat_search.search_data).to be_instance_of(Array)
    end

  end

  describe "#results" do

    it "is an array" do
      expect(@boat_search.results).to be_instance_of(Array)
    end

    it "should contain Video objects" do
      expect(@boat_search.results.first).to be_instance_of(Video)
    end

    it "should only contain three Video objects" do
      expect(@boat_search.results.length).to eq 3
    end

  end

end
