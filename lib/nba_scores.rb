# require "../nba_scores/version"     #causes error for some reason

# == remove soon
require "uri"
require "net/http"
require 'rest-client'
require 'json'
# ==

module NbaScores
  class Error < StandardError; end
  # Your code goes here...

  # date is YEAR(4)MONTH(02)DAY(02)
  url = RestClient.get("http://data.nba.net/prod/v2/20200307/scoreboard.json")
  current_day_scoreboard = JSON.parse(url)["games"]
    current_day_scoreboard.map do |games|
      # get all current gameId's for today
      puts games["gameId"]
    end 
  # puts pokemon_data


end
