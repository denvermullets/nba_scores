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

def get_todays_games
  # date is YEAR(4)MONTH(02)DAY(02) -aka- "20200307"
  url = RestClient.get("http://data.nba.net/prod/v2/#{get_today}/scoreboard.json")
  current_day_scoreboard = JSON.parse(url)["games"]
    # iterate thru list of games today and pull head to head matchups and start time
    games_today = {}
    current_day_scoreboard.each do |games|
      teamvsteam = get_team_matchup(games["gameId"])
      games_today[teamvsteam] = [games["gameId"]]
    end
    # returns hash of "Away vs Home @ Time" => "gameId"
    games_today
end 

def get_team_matchup(gameId)
  # takes in a "gameId" and returns the "Visitor vs Home || Game Time"
  url = RestClient.get("http://data.nba.net/prod/v1/#{get_today}/#{gameId}_boxscore.json")
  game = JSON.parse(url)
  # returns "Away vs Home @ Time"
  team_matchup = "#{game["basicGameData"]["vTeam"]["triCode"]} vs #{game["basicGameData"]["hTeam"]["triCode"]} @ #{game["basicGameData"]["startTimeEastern"]}"
end 

def get_recent_play(gameId)
  # iterate thru recent plays for selected game
  # need to add ability to determine what quarter game is in
  
  # until logic is put in - change period manually *******
  period = 2
  url = RestClient.get("http://data.nba.net/prod/v1/#{get_today}/#{gameId}_pbp_#{period}.json")
  play_by_play = JSON.parse(url)["plays"]

  # let's iterate thru array of hashes and create our own array with recent plays
  recent_plays = []
  play_by_play.each do |plays|
    play_to_push = "#{plays["clock"]} - #{plays["formatted"]["description"]}"
    recent_plays << play_to_push
  end 
  recent_plays
end 

def get_game_data(game_id)
  # code very inspired by:
  # https://medium.com/@sotek222/sewing-programs-with-the-ruby-thread-class-7de27ca40e0d

  # create new thread so that user input can still be acknowledged while we send a GET request to the 
  # server to see if there's an update to the play by play
  Thread.new do
    loop do
      system('clear')
      puts get_recent_play(game_id)
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

