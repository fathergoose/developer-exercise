require "net/http"
require "uri"
require "json"

API_KEY = ENV["YOUTUBE_API_KEY"]

class YoutubeSearch
  attr_reader :search_data, :results
  
  def initialize(query)
    uri = URI.parse("https://www.googleapis.com/youtube/v3/search?part=snippet&q=boating&key=#{API_KEY}")
    response_hash = JSON.parse(Net::HTTP.get(uri))
    @search_data = response_hash["items"]
    @results = []
  end

end
