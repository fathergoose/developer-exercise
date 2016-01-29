require 'spec_helper'

RSpec.describe Video do

  before :each do
    @video = Video.new "some_title", "https://some.url/"
  end
  
  describe "#new" do
    it "takes two arguments and returns a Video object" do
      expect(@video == true)
    end
  end

end
