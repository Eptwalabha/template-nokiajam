class_name Health
## The health class. Manages health.
##
## Get health, heal, hurt, etc.

## The minimum health
var _min_health = 0.0
## The maximum health
var _max_health = 100.0
## The current health
var _health = 100.0


func _init(new_min_health: float = 0, new_max_health: float = 100, new_health: float = 100):
	set_max_health(new_max_health)
	_set_min_health(new_min_health)
	_set_health(new_health)


# Public methods

## Get health. Returns float
func get_health() -> float:
	return _health

## Get minimum health. Returns float
func get_min_health() -> float:
	return _min_health

## Get maximum health. Return float
func get_max_health() -> float:
	return _max_health

## Reduce health by input float
func hurt(damage):
	var new_health = get_health() - damage
	if new_health < get_min_health():
		_set_health(get_min_health())
	else:
		_set_health(new_health)

## Increase health by input float
func heal(amount):
	var new_health = get_health() + amount
	if new_health > get_max_health():
		_set_health(get_max_health())
	else:
		_set_health(new_health)


func set_max_health(new_max_health):
	_max_health = new_max_health


# Private methods

func _set_min_health(new_min_health):
	_min_health = new_min_health


func _set_health(new_health):
	_health = new_health
