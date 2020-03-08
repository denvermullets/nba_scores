


def start_program
    # this is where the main menu options live
    prompt = TTY::Prompt.new
    choices = get_todays_games(get_today)
    game_select = prompt.select("Here are today's games, select the one you wish to view:", choices)


end 
 