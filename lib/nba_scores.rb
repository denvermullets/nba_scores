# == remove soon
require "uri"
require "net/http"
require 'rest-client'
require 'json'
require 'pry'
# ==

def get_today
  # get today's date and format for use w/the api
  # ex: 20200307
  Time.now.strftime("%Y%m%d")
end 

def get_todays_games(today_date)
  # date is YEAR(4)MONTH(02)DAY(02) -aka- "20200307"
  url = RestClient.get("http://data.nba.net/prod/v2/#{today_date}/scoreboard.json")
  current_day_scoreboard = JSON.parse(url)["games"]
    current_day_scoreboard.map do |games|
      # iterate thru array of hashes to get all current gameId's for today
      games["gameId"]
    end 
end 