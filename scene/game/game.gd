extends Node2D

@export var ingameui: Control


func _process(delta):
	if TIME.frozen and !ingameui.active:
		ingameui.activate()
	elif !TIME.frozen and ingameui.active:
		ingameui.deactivate()
