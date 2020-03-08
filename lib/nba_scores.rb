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
      # iterate thru array of hashes to get all current gameId's for today, returns an array
      games["gameId"]
    end 
end 

def get_game_data
  # code very inspired by:
  # https://medium.com/@sotek222/sewing-programs-with-the-ruby-thread-class-7de27ca40e0d

  # create new thread so that user input can still be acknowledged while we send a GET request to the 
  # server to see if there's an update to the play by play
  Thread.new do
    loop do
      system('clear')
      puts get_todays_games(get_today)
      print "Type 'exit' to quit: "
      sleep 40 # basically every 40 seconds ping the server to get an update
    end
  end
  puts "Type 'exit' to quit: "
  response = gets.chomp
  while response != "exit" do 
    puts "Type 'exit' to quit: "
    response = gets.chomp
  end

end 

