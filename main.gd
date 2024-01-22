@tool
extends Node

@onready var screen : SubViewport = $Screen
@onready var shaderRect : ColorRect = $ColorRect

@export var orientation: ORIENTATION = ORIENTATION.LANDSCAPE
@export var palette: PALETTE = PALETTE.ORIGINAL

enum ORIENTATION {
	LANDSCAPE,
	PORTRAIT
}

enum PALETTE {
	ORIGINAL,
	HARSH,
	GREY
}

func _ready() -> void:
	# update screen resolution
	var screen_resolution = Vector2(84, 48) if orientation == ORIENTATION.LANDSCAPE else Vector2(48, 84)
	screen.size = screen_resolution
	shaderRect.material.set("shader_parameter/screen_resolution", screen_resolution)

	# update palette color
	match palette:
		PALETTE.ORIGINAL:
			shaderRect.material.set("shader_parameter/color_white", Color("#c7f0d8"))
			shaderRect.material.set("shader_parameter/color_black", Color("#43523d"))
		PALETTE.HARSH:
			shaderRect.material.set("shader_parameter/color_white", Color("#9bc700"))
			shaderRect.material.set("shader_parameter/color_black", Color("#2b3f09"))
		PALETTE.GREY:
			shaderRect.material.set("shader_parameter/color_white", Color("#879188"))
			shaderRect.material.set("shader_parameter/color_black", Color("#1a1914"))
