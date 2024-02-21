extends Control

# 1280x720

@onready var freeze_ui = $FreezeUI
@onready var animation_player = $AnimationPlayer

## Current active state. Used by the game node in game.tscn
var active = true

## GameUI activation script. Will run once when time is frozen
func activate():
	active = true
	animation_player.play("freeze_in")

## GameUI deactivation script. Will run once when time is unfrozen
func deactivate():
	active = false
	animation_player.play("freeze_out")

