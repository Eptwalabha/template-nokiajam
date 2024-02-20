extends Node2D

@export var _player: CharacterBody2D
var _damage = 5
var _distance_from_player = 15
var _rotation_speed = 3
var _angle = 0


func _physics_process(delta):
	if !TIME.frozen:
		_angle += _rotation_speed * delta
		position = round(_player.position + (_distance_from_player * Vector2(cos(_angle), sin(_angle))))


func _on_area_2d_body_entered(body):
	if body.has_method("hurt"):
		body.hurt(_damage)
