


def start_program
    # this is where the main menu options live
    prompt = TTY::Prompt.new
    choices = get_todays_games
    game_select = prompt.select("Here are today's games, select the one you wish to view:", choices)

    # binding.pry
    # for some reason it's showing game_select as an array, which must be a byproduct of when the hash is built
    # need to research further
    get_game_data(game_select[0])

end 
 