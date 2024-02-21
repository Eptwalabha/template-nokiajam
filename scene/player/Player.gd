extends CharacterBody2D


@export var speed = 15

@onready var _player_sprite = $PlayerSprite

var health = Health.new()
var moving = false
var _virtual_position = Vector2(0.0, 0.0)
var _cooldown = 0.0
var _hurting = false


func get_input():
	var input_direction = Input.get_vector("key_4", "key_6", "key_2", "key_8")
	moving = (input_direction != Vector2(0, 0))
	velocity = input_direction * speed

func _physics_process(delta):
	_update_player_sprite()
	
	get_input()
	position = _virtual_position
	move_and_slide()
	_virtual_position = position
	position = round(position)
	
	_cooldown -= delta
	if _cooldown < 0:
		_cooldown = 0
	if moving:
		TIME.unfreeze()
		_cooldown = 0.3
	elif _cooldown <= 0:
		TIME.freeze()


func _update_player_sprite():
	if _hurting:
		if _player_sprite.animation != "hurt":
			_player_sprite.play("hurt")
		if !_player_sprite.is_playing():
			_player_sprite.play()
		if _player_sprite.frame == 2:
			_player_sprite = false
	else:
		if moving:
			if _player_sprite.animation != "right":
				_player_sprite.play("right")
		else:
			if _player_sprite.animation != "idle":
				_player_sprite.play("idle")
		if !_player_sprite.is_playing():
			_player_sprite.play()
	_sprite_flipping()

func _sprite_flipping():
	if velocity.x > 0:
		_player_sprite.flip_h = false
		_player_sprite.offset.x = 0
	elif velocity.x < 0:
		_player_sprite.flip_h = true
		_player_sprite.offset.x = 2
