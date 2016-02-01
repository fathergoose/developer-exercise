Use your favorite method for assigning environment variables
for the API_KEY

```ruby
  API_KEY = ENV["YOUTUBE_API_KEY"]
```

For example, if using bash:

```term
  $ echo "export YOUTUBE_API_KEY=some_api_key" >> ~/.bashrc
```

Utilize the perform a YouTube search by creating a new YoutubeSearch
object with a search string as it's single argument.

```ruby
  dog_search = YoutubeSearch.new('funny dog videos')

  dog_search.results
  => [<Video:0x00561ff4d76e90 @title="Funny Dogs - A Funny Dog Videos Compilation 2015", @url="https://youtube.com/watch?v=GF60Iuh643I">, <Video:0x00561ff4d76df0 @title="Ultimate Funny Dog Videos Compilation 2013", @url="https://youtube.com/watch?v=dGpZEuXoFWw">, <Video:0x00561ff4d76b48 @title="10 Funniest Dog Videos", @url="https://youtube.com/watch?v=6j7oQletFbc">]

  dog_search.results.first.title
  => "Funny Dogs - A Funny Dog Videos Compilation 2015"

```
