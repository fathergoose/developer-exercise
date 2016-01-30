require "net/http"
require "uri"
require "json"

API_KEY = ENV["YOUTUBE_API_KEY"]
YOUTUBE_V3_SEARCH = "https://www.googleapis.com/youtube/v3/search"
YOUTUBE_WATCH = "https://youtube.com/watch?v="

class YoutubeSearch
  attr_reader :search_data, :results
  
  def initialize(query)
    uri = URI.parse("#{YOUTUBE_V3_SEARCH}?part=snippet&q=#{query}&key=#{API_KEY}")
    response_hash = JSON.parse(Net::HTTP.get(uri))
    @search_data = response_hash["items"]
    @results = []
    @search_data.each do |result|
      result_id = result["id"]["videoId"]
      result_title = result["snippet"]["title"]
      result_watch_url = "#{YOUTUBE_WATCH}#{result_id}"
      video = Video.new(result_title, result_watch_url)
      @results << video
    end
  end

end
