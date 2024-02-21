extends CharacterBody2D

enum Enemies {BAT}
@export var speed = 5
var health = Health.new()
var player: CharacterBody2D
var type: Enemies
var _virtual_position = Vector2(0, 0)
var _hurting = false
@onready var _bat = $Bat



func _physics_process(delta):
	match type:
		Enemies.BAT:
			_bat_control()
			_bat_animation_control()


func init(new_player: CharacterBody2D, enemy_type: Enemies):
	player = new_player
	reset(enemy_type)


func reset(enemy_type: Enemies):
	pass


func hurt(damage):
	_hurting = true
	health.hurt(damage)


func _sprite_flipping(sprite: AnimatedSprite2D):
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true


func _bat_control():
	if !player or TIME.frozen:
		return
	
	var angle = global_position.angle_to_point(player.global_position)
	if _hurting:
		velocity = Vector2(cos(angle), sin(angle))
		velocity = velocity * speed * -5
	else:
		velocity = Vector2(cos(angle), sin(angle))
		velocity = velocity * speed
	global_position = _virtual_position
	move_and_slide()
	_virtual_position = global_position
	global_position = round(global_position)


func _bat_animation_control():
	if TIME.frozen:
		_bat.pause()
	else:
		if _hurting:
			if _bat.animation != "hurt":
				_bat.play("hurt")
			if !_bat.is_playing():
				_bat.play()
			if _bat.frame == 2:
				_hurting = false
		else:
			if _bat.animation != "flying":
				_bat.play("flying")
			if !_bat.is_playing():
				_bat.play()
			_sprite_flipping(_bat)
