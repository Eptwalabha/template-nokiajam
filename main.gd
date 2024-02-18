@tool
extends Node

@onready var screen : SubViewport = %Screen
@onready var aspect_ratio_container: AspectRatioContainer = %AspectRatioContainer

@export var screen_orientation: ORIENTATION = ORIENTATION.LANDSCAPE : set = set_orientation
@export var palette: PALETTE = PALETTE.ORIGINAL : set = set_palette

# (30mm / 84px) / (22mm / 48px) = 0.779
@export var pixel_ratio : float = 0.779 : set = set_pixel_ratio

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

var resolution = Vector2(84, 48)

func _ready() -> void:
	_update_aspect_ratio()

func set_orientation(new_screen_orientation: ORIENTATION) -> void:
	if screen_orientation != new_screen_orientation:
		pixel_ratio = 1.0 / pixel_ratio
	screen_orientation = new_screen_orientation
	resolution = Vector2(84.0, 48.0)
	if screen_orientation == ORIENTATION.PORTRAIT:
		resolution = Vector2(48.0, 84.0)
	_update_aspect_ratio()

func set_pixel_ratio(new_pixel_ratio: float) -> void:
	pixel_ratio = max(0.01, new_pixel_ratio)
	_update_aspect_ratio()

func _update_aspect_ratio() -> void:
	var ratio : float = resolution.x / resolution.y
	ratio *= pixel_ratio
	RenderingServer.global_shader_parameter_set("screen_resolution", resolution)
	if screen:
		screen.size = resolution
	if aspect_ratio_container:
		aspect_ratio_container.ratio = ratio

func set_palette(new_palette: PALETTE) -> void:
	palette = new_palette
	RenderingServer.global_shader_parameter_set("color_palette_light", Color(palettes[palette][0]))
	RenderingServer.global_shader_parameter_set("color_palette_dark",  Color(palettes[palette][1]))
