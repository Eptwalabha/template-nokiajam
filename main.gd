@tool
extends Node

@onready var screen : SubViewport = $Screen
@onready var shaderRect : ColorRect = $NokiaShader

@export var screen_orientation: ORIENTATION = ORIENTATION.LANDSCAPE
@export var palette: PALETTE = PALETTE.ORIGINAL : set = set_palette

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
	set_orientation(screen_orientation)
	set_palette(palette)

func set_orientation(new_screen_orientation: ORIENTATION) -> void:
	screen_orientation = new_screen_orientation
	var resolution = Vector2(84, 48)
	if screen_orientation == ORIENTATION.PORTRAIT:
		resolution = Vector2(48, 84)

	RenderingServer.global_shader_parameter_set("screen_resolution", resolution)
	if $Screen:
		$Screen.size = resolution

func set_palette(new_palette: PALETTE) -> void:
	palette = new_palette
	match palette:
		PALETTE.ORIGINAL:
			RenderingServer.global_shader_parameter_set("color_palette_light", Color("#c7f0d8"))
			RenderingServer.global_shader_parameter_set("color_palette_dark", Color("#43523d"))
		PALETTE.HARSH:
			RenderingServer.global_shader_parameter_set("color_palette_light", Color("#9bc700"))
			RenderingServer.global_shader_parameter_set("color_palette_dark", Color("#2b3f09"))
		PALETTE.GREY:
			RenderingServer.global_shader_parameter_set("color_palette_light", Color("#879188"))
			RenderingServer.global_shader_parameter_set("color_palette_dark", Color("#1a1914"))
