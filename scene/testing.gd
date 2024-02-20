extends Node2D

var health = Health.new(0, 100, 100)

func _ready():
	print(health.get_health())
