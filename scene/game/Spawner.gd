extends Node2D

@export var player: CharacterBody2D
@onready var enemy = preload("res://scene/enemy/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var e = enemy.instantiate()
	e.init(player, e.Enemies.BAT)
	add_child(e)
