@tool
extends Node

@onready var screen : SubViewport = %Screen
@onready var aspect_ratio_container: AspectRatioContainer = %AspectRatioContainer

@export var screen_orientation: ORIENTATION = ORIENTATION.LANDSCAPE : set = set_orientation
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

const palettes = {
	PALETTE.ORIGINAL: ["#c7f0d8", "#43523d"],
	PALETTE.HARSH: ["#9bc700", "#2b3f09"],
	PALETTE.GREY: ["#879188", "#1a1914"]
}

const LCD_DIMENSIONS = Vector2(30, 22)

func set_orientation(new_screen_orientation: ORIENTATION) -> void:
	screen_orientation = new_screen_orientation
	var resolution = Vector2(84, 48)
	var ratio = LCD_DIMENSIONS.x / LCD_DIMENSIONS.y
	if screen_orientation == ORIENTATION.PORTRAIT:
		resolution = Vector2(48, 84)
		ratio = LCD_DIMENSIONS.y / LCD_DIMENSIONS.x
	RenderingServer.global_shader_parameter_set("screen_resolution", resolution)
	if screen:
		screen.size = resolution
	if aspect_ratio_container:
		aspect_ratio_container.ratio = ratio

func set_palette(new_palette: PALETTE) -> void:
	palette = new_palette
	RenderingServer.global_shader_parameter_set("color_palette_light", Color(palettes[palette][0]))
	RenderingServer.global_shader_parameter_set("color_palette_dark",  Color(palettes[palette][1]))
