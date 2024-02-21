extends Control

# Hello hello, Cromain. Try to stay in this (in_game_ui.tscn) scene for all the in game UI work.
# It is already set up to activate and deactive when time is frozen via the scripts below.
# You shouldn't have to worry about implementing any code in the actual game scene itself.

# The UI is currently set to the viewport size of 1280x720, don't change that.
# It will automatically scale the UI correctly when you run the game
# So it will be weird because the text is gonna be really small while editing,
# but it will be right in the game. See the "test" text label as an example of that

## Current active state. Used by the game node in game.tscn
var active = true


## GameUI activation script. Will run once when time is frozen
func activate():
	active = true
	visible = true
	# any activation code can go here


## GameUI deactivation script. Will run once when time is unfrozen
func deactivate():
	active = false
	visible = false
	# any deactivation code can go here
