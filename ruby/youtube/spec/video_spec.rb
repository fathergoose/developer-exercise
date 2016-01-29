require 'spec_helper'

RSpec.describe Video do

  before :each do
    @video = Video.new "some_title", "https://some.url/"
  end
  
  describe "#new" do
    it "takes two arguments and returns a Video object" do
      expect(@video.class).to eq Video
    end
  end

  describe "#title" do
    it "returns the correct title" do
      expect(@video.title).to eq "some_title"
    end
  end

  describe "#url" do
    it "returns the correct url" do 
      expect(@video.url).to eq "https://some.url/"
    end
  end

end
